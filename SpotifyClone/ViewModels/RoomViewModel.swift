// RoomViewModel.swift
// SpotifyClone

import SwiftUI
import Combine

@MainActor
class RoomViewModel: ObservableObject {
    @Published var room: Room
    @Published var floatingEmojis: [FloatingEmoji] = []
    @Published var isPlaying: Bool = true
    @Published var myVote: String? = nil
    @Published var moodVoteCount: [String: Int] = [:]
    @Published var showQueueSheet: Bool = false
    @Published var progress: Double = 0.28

    private var emojiCounter = 0
    private var progressTimer: AnyCancellable?

    struct FloatingEmoji: Identifiable {
        let id: Int
        let emoji: String
        let xOffset: CGFloat
        var opacity: Double = 1.0
        var yOffset: CGFloat = 0
    }

    init(room: Room) {
        self.room = room
        updateMoodVoteCounts()
        simulateIncomingReactions()
        startProgressTimer()
    }

    // MARK: - Mood Voting
    func castMoodVote(_ emoji: String) {
        myVote = emoji
        sendReaction(emoji)
        updateMoodVoteCounts()
    }

    private func updateMoodVoteCounts() {
        var counts: [String: Int] = [:]
        for user in room.users {
            if let vote = user.moodVote {
                counts[vote, default: 0] += 1
            }
        }
        moodVoteCount = counts
    }

    var dominantMoodEmoji: String {
        moodVoteCount.max(by: { $0.value < $1.value })?.key ?? room.currentMood.emoji
    }

    // MARK: - Floating Reactions
    func sendReaction(_ emoji: String) {
        let floater = FloatingEmoji(
            id: emojiCounter,
            emoji: emoji,
            xOffset: CGFloat.random(in: -100...100)
        )
        emojiCounter += 1
        withAnimation { floatingEmojis.append(floater) }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) { [weak self] in
            self?.floatingEmojis.removeAll { $0.id == floater.id }
        }
    }

    // MARK: - DJ Queue Voting
    func voteForQueueItem(id: UUID) {
        guard let idx = room.djQueue.firstIndex(where: { $0.id == id }),
              !room.djQueue[idx].hasVoted else { return }
        room.djQueue[idx].votes += 1
        room.djQueue[idx].hasVoted = true
        room.djQueue.sort { $0.votes > $1.votes }
    }
    
    // MARK: - Playback Controls
    private func startProgressTimer() {
        progressTimer = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self, self.isPlaying else { return }
                withAnimation(.linear(duration: 1.0)) {
                    self.progress += 0.005 // Simulate progress
                    if self.progress >= 1.0 {
                        self.progress = 0
                    }
                }
            }
    }
    
    func skipForward() {
        withAnimation {
            progress = min(1.0, progress + 0.1)
        }
    }
    
    func skipBackward() {
        withAnimation {
            progress = max(0.0, progress - 0.1)
        }
    }

    // MARK: - Simulate incoming reactions (for realism)
    private func simulateIncomingReactions() {
        let reactionPool = ["🔥", "❤️", "🎵", "💃", "🌊", "✨", "🎉", "😍"]
        Timer.scheduledTimer(withTimeInterval: 3.5, repeats: true) { [weak self] _ in
            guard let self else { return }
            if Bool.random() {
                Task { @MainActor in
                    self.sendReaction(reactionPool.randomElement() ?? "🔥")
                }
            }
        }
    }
}

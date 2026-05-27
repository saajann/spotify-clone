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
    @Published var chatMessages: [ChatMessage] = []
    @Published var songVoteOptions: [SongVoteOption] = []
    @Published var hasVotedNextSong: Bool = false
    @Published var showSuggestSongSheet: Bool = false
    @Published var songSuggestionConfirmed: Bool = false
    @Published var suggestedSongName: String = ""

    private var emojiCounter = 0
    private var progressTimer: AnyCancellable?
    private var chatTimer: Timer?

    struct FloatingEmoji: Identifiable {
        let id: Int
        let emoji: String
        let xOffset: CGFloat
        var opacity: Double = 1.0
        var yOffset: CGFloat = 0
    }

    init(room: Room) {
        self.room = room
        self.chatMessages = room.chatMessages
        self.songVoteOptions = room.songVoteOptions
        updateMoodVoteCounts()
        simulateIncomingReactions()
        simulateIncomingChat()
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

    // MARK: - Chat
    func sendChatMessage(_ text: String) {
        guard !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        let message = ChatMessage(
            userName: "You",
            text: text,
            timestamp: currentTimeString(),
            isMe: true
        )
        withAnimation(.spring(response: 0.3)) {
            chatMessages.append(message)
        }
    }

    private func currentTimeString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: Date())
    }

    private func simulateIncomingChat() {
        let userNames = room.users.filter { !$0.isDJ }.map { $0.name }
        let chatPool = [
            "this is so good 🔥", "vibes ✨", "love this track!",
            "can we play this one more time? 🙏", "who else is vibing rn?",
            "such a mood 🌊", "this room is everything",
            "the DJ is killing it tonight 🎧", "perfect background music",
            "yesss this song!! 🎵", "anyone else dancing? 💃",
            "absolute banger 🔥🔥", "discovered this artist here fr"
        ]

        chatTimer = Timer.scheduledTimer(withTimeInterval: 8.0, repeats: true) { [weak self] _ in
            guard let self else { return }
            if Bool.random() && !userNames.isEmpty {
                Task { @MainActor in
                    let msg = ChatMessage(
                        userName: userNames.randomElement()!,
                        text: chatPool.randomElement()!,
                        timestamp: self.currentTimeString(),
                        isMe: false
                    )
                    withAnimation(.spring(response: 0.3)) {
                        self.chatMessages.append(msg)
                    }
                }
            }
        }
    }

    // MARK: - Song Voting
    func voteForNextSong(id: UUID) {
        guard !hasVotedNextSong else { return }
        if let idx = songVoteOptions.firstIndex(where: { $0.id == id }) {
            withAnimation(.spring(response: 0.4)) {
                songVoteOptions[idx].voteCount += 1
                songVoteOptions[idx].hasVoted = true
                hasVotedNextSong = true
            }
        }
    }

    var totalSongVotes: Int {
        songVoteOptions.reduce(0) { $0 + $1.voteCount }
    }

    func votePercentage(for option: SongVoteOption) -> Double {
        guard totalSongVotes > 0 else { return 0 }
        return Double(option.voteCount) / Double(totalSongVotes)
    }

    // MARK: - Song Suggestion
    func suggestSong(_ song: Song) {
        let newItem = QueueItem(song: song, proposedBy: "You", votes: 1, hasVoted: true)
        room.djQueue.append(newItem)
        suggestedSongName = song.title
        withAnimation(.spring()) {
            songSuggestionConfirmed = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            withAnimation { self?.songSuggestionConfirmed = false }
        }
    }

    // MARK: - Playback Controls
    private func startProgressTimer() {
        progressTimer = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self, self.isPlaying else { return }
                withAnimation(.linear(duration: 1.0)) {
                    self.progress += 0.005
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

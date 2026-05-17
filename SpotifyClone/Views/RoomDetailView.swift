// RoomDetailView.swift
// SpotifyClone
//
// 🌐 VIBE ROOMS — Innovative Features:
//   1. Mood Ring AI — animated rotating gradient ring that represents the collective mood
//   2. Spatial Avatar Circle — users positioned in a circle, DJ in center with crown + pulse
//   3. Live Floating Reactions — emoji burst up from bottom, auto-generated + user-triggered
//   4. Democratic DJ Queue — anyone proposes songs, vote to rank them, top song plays next
//   5. Mood Voting Panel — cast an emoji vote that contributes to the collective mood display

import SwiftUI

struct RoomDetailView: View {
    let room: Room
    @EnvironmentObject var player: PlayerViewModel
    @StateObject private var vm: RoomViewModel
    @State private var activeTab: RoomTab = .room
    @Environment(\.dismiss) var dismiss

    enum RoomTab: String, CaseIterable {
        case room = "Room"
        case queue = "Queue"
        case chat = "Chat"
    }

    init(room: Room) {
        self.room = room
        _vm = StateObject(wrappedValue: RoomViewModel(room: room))
    }

    var body: some View {
        ZStack {
            // Dynamic mood background
            LinearGradient(
                colors: vm.room.currentMood.gradient + [Color.spotifyBlack],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            .animation(.easeInOut(duration: 1.5), value: vm.room.currentMood)

            // Floating emoji overlay
            FloatingEmojiOverlay(floaters: vm.floatingEmojis)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .padding(.bottom, 180)

            VStack(spacing: 0) {
                // Top bar
                topBar

                // Segmented tabs
                tabSelector

                // Content
                if activeTab == .room {
                    roomContent
                } else if activeTab == .queue {
                    queueContent
                } else {
                    chatContent
                }
            }
        }
        .navigationBarHidden(true)
        .preferredColorScheme(.dark)
    }

    // MARK: - Top Bar
    private var topBar: some View {
        HStack {
            Button { dismiss() } label: {
                Image(systemName: "chevron.down")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white)
            }

            Spacer()

            VStack(spacing: 2) {
                HStack(spacing: 5) {
                    if vm.room.isLive {
                        Circle().fill(Color.red).frame(width: 6, height: 6)
                        Text("LIVE").font(.system(size: 10, weight: .black)).foregroundColor(.red)
                    }
                }
                Text(vm.room.name)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
            }

            Spacer()

            ShareLink(item: "Join my Vibe Room: \(vm.room.name) on SpotifyClone!") {
                Image(systemName: "square.and.arrow.up")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 12)
    }

    // MARK: - Tab Selector
    private var tabSelector: some View {
        HStack(spacing: 0) {
            ForEach(RoomTab.allCases, id: \.rawValue) { tab in
                Button {
                    withAnimation(.easeInOut(duration: 0.2)) { activeTab = tab }
                } label: {
                    VStack(spacing: 6) {
                        Text(tab.rawValue)
                            .font(.system(size: 14, weight: activeTab == tab ? .bold : .regular))
                            .foregroundColor(activeTab == tab ? .white : .white.opacity(0.5))
                        Rectangle()
                            .fill(activeTab == tab ? vm.room.currentMood.accentColor : Color.clear)
                            .frame(height: 2)
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal, 8)
        .background(Color.clear)
    }

    // MARK: - Room Tab Content
    private var roomContent: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 24) {

                // Mood Ring + Now Playing
                ZStack {
                    MoodRingView(mood: vm.room.currentMood)
                        .frame(width: 90, height: 90)

                    RoundedRectangle(cornerRadius: 10)
                        .fill(LinearGradient(
                            colors: vm.room.currentSong.albumGradient,
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        .frame(width: 60, height: 60)
                        .shadow(color: vm.room.currentSong.dominantColor.opacity(0.5), radius: 12)
                }

                // Song Info
                VStack(spacing: 4) {
                    Text(vm.room.currentSong.title)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                    Text(vm.room.currentSong.artist)
                        .font(.system(size: 15))
                        .foregroundColor(.white.opacity(0.7))
                }

                // Progress bar (collective, non-interactive display)
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        Capsule().fill(Color.white.opacity(0.2)).frame(height: 3)
                        Capsule()
                            .fill(vm.room.currentMood.accentColor)
                            .frame(width: geo.size.width * vm.progress, height: 3)
                    }
                }
                .frame(height: 3)
                .padding(.horizontal, 40)

                // Play controls (DJ only in real app — here always shown)
                HStack(spacing: 32) {
                    Button { vm.skipBackward() } label: {
                        Image(systemName: "backward.fill").font(.system(size: 22)).foregroundColor(.white.opacity(0.7))
                    }
                    PlayPauseButton(isPlaying: $vm.isPlaying, size: 60, color: vm.room.currentMood.accentColor)
                    Button { vm.skipForward() } label: {
                        Image(systemName: "forward.fill").font(.system(size: 22)).foregroundColor(.white.opacity(0.7))
                    }
                }

                // Spatial Avatar Circle
                Text("In the Room")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white.opacity(0.8))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)

                UserAvatarCircleView(
                    users: vm.room.users,
                    radius: 130,
                    mood: vm.room.currentMood
                )
                .frame(width: 260, height: 260)
                .padding(.vertical, 8)

                // Listener count
                HStack(spacing: 6) {
                    Image(systemName: "person.2.fill").foregroundColor(.white.opacity(0.5))
                    Text("\(vm.room.listenerCount) listening").foregroundColor(.white.opacity(0.5))
                }
                .font(.system(size: 13))

                // MARK: Mood Voting Panel
                moodVotingPanel

                // MARK: Reaction Bar
                reactionBar

                Spacer(minLength: 80)
            }
            .padding(.top, 16)
        }
    }

    // MARK: - Mood Voting Panel
    private var moodVotingPanel: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "waveform.path.ecg")
                    .foregroundColor(vm.room.currentMood.accentColor)
                Text("Collective Mood")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(.white)
                Spacer()
                Text("AI Analyzed")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(vm.room.currentMood.accentColor)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(vm.room.currentMood.accentColor.opacity(0.15))
                    .clipShape(Capsule())
            }

            // Vote bars
            let totalVotes = max(1, vm.moodVoteCount.values.reduce(0, +))
            ForEach(Array(vm.moodVoteCount.sorted(by: { $0.value > $1.value }).prefix(4)), id: \.key) { emoji, count in
                HStack(spacing: 10) {
                    Text(emoji).font(.system(size: 18))
                    GeometryReader { geo in
                        ZStack(alignment: .leading) {
                            Capsule().fill(Color.white.opacity(0.1)).frame(height: 8)
                            Capsule()
                                .fill(vm.room.currentMood.accentColor)
                                .frame(width: geo.size.width * CGFloat(count) / CGFloat(totalVotes), height: 8)
                        }
                    }
                    .frame(height: 8)
                    Text("\(count)").font(.caption).foregroundColor(.white.opacity(0.6)).frame(width: 20)
                }
            }

            // My vote row
            HStack(spacing: 8) {
                Text("Your vote:")
                    .font(.system(size: 13))
                    .foregroundColor(.white.opacity(0.6))
                ForEach(["🌊", "🔥", "🧠", "🎉", "💫", "🫧"], id: \.self) { emoji in
                    Button {
                        vm.castMoodVote(emoji)
                    } label: {
                        Text(emoji)
                            .font(.system(size: 22))
                            .padding(6)
                            .background(vm.myVote == emoji ? Color.white.opacity(0.2) : Color.clear)
                            .clipShape(Circle())
                    }
                }
            }
        }
        .padding(16)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal, 16)
    }

    // MARK: - Reaction Bar
    private var reactionBar: some View {
        VStack(spacing: 12) {
            Text("React Live")
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(.white.opacity(0.5))

            HStack(spacing: 16) {
                ForEach(["🔥", "❤️", "🎵", "💃", "✨", "😍", "🎉"], id: \.self) { emoji in
                    Button {
                        vm.sendReaction(emoji)
                    } label: {
                        Text(emoji)
                            .font(.system(size: 28))
                            .padding(10)
                            .background(Color.white.opacity(0.08))
                            .clipShape(Circle())
                    }
                    .scaleEffect(1.0)
                    .buttonStyle(BounceButtonStyle())
                }
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal, 16)
    }

    // MARK: - Queue Tab
    private var queueContent: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Image(systemName: "music.note.list")
                        .foregroundColor(vm.room.currentMood.accentColor)
                    Text("Democratic Queue")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                    Spacer()
                    Text("Vote for next!")
                        .font(.caption)
                        .foregroundColor(vm.room.currentMood.accentColor)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 16)

                ForEach(vm.room.djQueue) { item in
                    QueueItemRow(item: item, mood: vm.room.currentMood) {
                        vm.voteForQueueItem(id: item.id)
                    }
                }

                Spacer(minLength: 100)
            }
        }
    }

    // MARK: - Chat Tab (decorative)
    private var chatContent: some View {
        VStack {
            Spacer()
            Image(systemName: "bubble.left.and.bubble.right")
                .font(.system(size: 44))
                .foregroundColor(.white.opacity(0.3))
            Text("Live Chat")
                .font(.headline)
                .foregroundColor(.white.opacity(0.5))
            Text("Chat with everyone in the room")
                .font(.caption)
                .foregroundColor(.white.opacity(0.35))
            Spacer()
        }
    }
}

// MARK: - Queue Item Row
private struct QueueItemRow: View {
    let item: QueueItem
    let mood: VibeMood
    let onVote: () -> Void

    var body: some View {
        HStack(spacing: 14) {
            // Rank indicator
            RoundedRectangle(cornerRadius: 6)
                .fill(LinearGradient(colors: item.song.albumGradient, startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 48, height: 48)

            VStack(alignment: .leading, spacing: 3) {
                Text(item.song.title)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.white)
                Text("\(item.song.artist) · proposed by @\(item.proposedBy)")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.6))
                    .lineLimit(1)
            }

            Spacer()

            // Vote button
            Button(action: onVote) {
                HStack(spacing: 4) {
                    Image(systemName: item.hasVoted ? "heart.fill" : "heart")
                        .font(.system(size: 14))
                    Text("\(item.votes)")
                        .font(.system(size: 14, weight: .bold))
                }
                .foregroundColor(item.hasVoted ? mood.accentColor : .white.opacity(0.6))
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(item.hasVoted ? mood.accentColor.opacity(0.15) : Color.white.opacity(0.08))
                .clipShape(Capsule())
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .background(
            item.votes == (MockData.rooms.flatMap { $0.djQueue }.max(by: { $0.votes < $1.votes })?.votes ?? 0) && item.votes > 0
            ? mood.accentColor.opacity(0.05)
            : Color.clear
        )
    }
}

// MARK: - Bounce button style
struct BounceButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.82 : 1.0)
            .animation(.spring(response: 0.25, dampingFraction: 0.5), value: configuration.isPressed)
    }
}

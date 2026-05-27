// RoomDetailView.swift
// SpotifyClone

import SwiftUI

struct RoomDetailView: View {
    let room: Room
    var onLeave: (() -> Void)? = nil
    
    @EnvironmentObject var player: PlayerViewModel
    @StateObject private var vm: RoomViewModel
    @State private var activeTab: RoomTab = .room
    @Environment(\.dismiss) var dismiss
    @State private var chatInputText: String = ""

    enum RoomTab: String, CaseIterable {
        case room = "Room"
        case queue = "Queue"
        case chat = "Chat"
    }

    init(room: Room, onLeave: (() -> Void)? = nil) {
        self.room = room
        self.onLeave = onLeave
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
        .sheet(isPresented: $vm.showSuggestSongSheet) {
            SuggestSongView { song in
                vm.suggestSong(song)
            }
        }
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

            Button {
                onLeave?()
                dismiss()
            } label: {
                Image(systemName: "rectangle.portrait.and.arrow.right")
                    .font(.system(size: 18))
                    .foregroundColor(.red)
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

                // Suggest Song Button
                Button {
                    vm.showSuggestSongSheet = true
                } label: {
                    HStack {
                        Image(systemName: "music.note.list")
                        Text("Suggest a Song")
                    }
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 24)
                    .background(Color.white.opacity(0.15))
                    .clipShape(Capsule())
                    .overlay(
                        Capsule()
                            .stroke(vm.room.currentMood.accentColor.opacity(0.4), lineWidth: 1)
                    )
                }
                .padding(.top, 8)
                
                if vm.songSuggestionConfirmed {
                    Text("Suggested: \(vm.suggestedSongName)")
                        .font(.caption)
                        .foregroundColor(vm.room.currentMood.accentColor)
                        .transition(.opacity)
                }

                // Vote Next Song Section
                if !vm.songVoteOptions.isEmpty {
                    voteNextSongPanel
                }

                // Reaction Bar
                reactionBar

                Spacer(minLength: 80)
            }
            .padding(.top, 16)
        }
    }

    // MARK: - Vote Next Song Panel
    private var voteNextSongPanel: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "list.number")
                    .foregroundColor(vm.room.currentMood.accentColor)
                Text("Vote Next Song")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                Spacer()
                if vm.hasVotedNextSong {
                    Text("Voted")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(vm.room.currentMood.accentColor)
                        .clipShape(Capsule())
                }
            }

            VStack(spacing: 12) {
                ForEach(vm.songVoteOptions) { option in
                    Button {
                        vm.voteForNextSong(id: option.id)
                    } label: {
                        HStack(spacing: 12) {
                            RoundedRectangle(cornerRadius: 6)
                                .fill(LinearGradient(colors: option.song.albumGradient, startPoint: .topLeading, endPoint: .bottomTrailing))
                                .frame(width: 40, height: 40)
                                .overlay(
                                    Image(systemName: "play.fill")
                                        .foregroundColor(.white.opacity(0.8))
                                        .font(.caption)
                                )

                            VStack(alignment: .leading, spacing: 4) {
                                Text(option.song.title)
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.white)
                                    .lineLimit(1)
                                Text(option.song.artist)
                                    .font(.system(size: 12))
                                    .foregroundColor(.white.opacity(0.6))
                                    .lineLimit(1)
                            }

                            Spacer()

                            if vm.hasVotedNextSong {
                                Text("\(Int(vm.votePercentage(for: option) * 100))%")
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(option.hasVoted ? vm.room.currentMood.accentColor : .white.opacity(0.7))
                            } else {
                                Circle()
                                    .stroke(Color.white.opacity(0.3), lineWidth: 1)
                                    .frame(width: 20, height: 20)
                            }
                        }
                        .padding(12)
                        .background(Color.white.opacity(0.05))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(option.hasVoted ? vm.room.currentMood.accentColor : Color.clear, lineWidth: 2)
                        )
                        .overlay(
                            GeometryReader { geo in
                                if vm.hasVotedNextSong {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(vm.room.currentMood.accentColor.opacity(0.15))
                                        .frame(width: geo.size.width * CGFloat(vm.votePercentage(for: option)))
                                        .animation(.spring(response: 0.6), value: vm.hasVotedNextSong)
                                }
                            }
                            , alignment: .leading
                        )
                    }
                    .buttonStyle(.plain)
                    .disabled(vm.hasVotedNextSong)
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

    // MARK: - Chat Tab
    private var chatContent: some View {
        VStack(spacing: 0) {
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(vm.chatMessages) { message in
                            ChatBubble(message: message, room: vm.room)
                                .id(message.id)
                        }
                    }
                    .padding()
                }
                .onChange(of: vm.chatMessages.count) {
                    if let lastMessage = vm.chatMessages.last {
                        withAnimation {
                            proxy.scrollTo(lastMessage.id, anchor: .bottom)
                        }
                    }
                }
                .onAppear {
                    if let lastMessage = vm.chatMessages.last {
                        proxy.scrollTo(lastMessage.id, anchor: .bottom)
                    }
                }
            }

            // Chat Input
            HStack(spacing: 12) {
                TextField("Say something...", text: $chatInputText)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(20)
                    .foregroundColor(.white)
                    .font(.system(size: 15))
                    .submitLabel(.send)
                    .onSubmit {
                        sendMessage()
                    }

                Button {
                    sendMessage()
                } label: {
                    Image(systemName: "paperplane.fill")
                        .font(.system(size: 18))
                        .foregroundColor(chatInputText.isEmpty ? .white.opacity(0.3) : vm.room.currentMood.accentColor)
                        .padding(10)
                        .background(Color.white.opacity(0.05))
                        .clipShape(Circle())
                }
                .disabled(chatInputText.isEmpty)
            }
            .padding(16)
            .background(Color.spotifyBlack.opacity(0.8))
        }
    }

    private func sendMessage() {
        guard !chatInputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        vm.sendChatMessage(chatInputText)
        chatInputText = ""
    }
}

// MARK: - Chat Bubble
private struct ChatBubble: View {
    let message: ChatMessage
    let room: Room

    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {
            if message.isMe {
                Spacer()
            } else {
                // Avatar for others
                if let user = room.users.first(where: { $0.name == message.userName }) {
                    ZStack {
                        Circle()
                            .fill(LinearGradient(
                                colors: [Color(hex: user.profileImageURL), Color(hex: user.profileImageURL).opacity(0.6)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ))
                            .frame(width: 28, height: 28)
                        
                        Text(String(user.name.prefix(1)).uppercased())
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(.white)
                    }
                } else {
                    Circle()
                        .fill(Color.gray)
                        .frame(width: 28, height: 28)
                        .overlay(Text(String(message.userName.prefix(1)).uppercased()).font(.system(size: 11, weight: .bold)).foregroundColor(.white))
                }
            }

            VStack(alignment: message.isMe ? .trailing : .leading, spacing: 4) {
                HStack(spacing: 6) {
                    if !message.isMe {
                        Text(message.userName)
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.white.opacity(0.6))
                    }
                    Text(message.timestamp)
                        .font(.system(size: 10))
                        .foregroundColor(.white.opacity(0.4))
                }

                Text(message.text)
                    .font(.system(size: 15))
                    .foregroundColor(message.isMe ? .black : .white)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(message.isMe ? room.currentMood.accentColor : Color.white.opacity(0.1))
                    .cornerRadius(16)
            }

            if !message.isMe {
                Spacer()
            }
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

// MARK: - Suggest Song View
struct SuggestSongView: View {
    @Environment(\.dismiss) var dismiss
    @State private var searchText = ""
    var onSuggest: (Song) -> Void

    var filteredSongs: [Song] {
        if searchText.isEmpty {
            return MockData.songs
        } else {
            return MockData.songs.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.artist.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.spotifyBlack.ignoresSafeArea()

                VStack {
                    // Search bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.white.opacity(0.5))
                        TextField("Search for a song...", text: $searchText)
                            .foregroundColor(.white)
                            .font(.system(size: 16))
                        if !searchText.isEmpty {
                            Button {
                                searchText = ""
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.white.opacity(0.5))
                            }
                        }
                    }
                    .padding(12)
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(10)
                    .padding()

                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(filteredSongs) { song in
                                HStack {
                                    RoundedRectangle(cornerRadius: 6)
                                        .fill(LinearGradient(colors: song.albumGradient, startPoint: .topLeading, endPoint: .bottomTrailing))
                                        .frame(width: 48, height: 48)
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(song.title)
                                            .font(.system(size: 16, weight: .semibold))
                                            .foregroundColor(.white)
                                        Text(song.artist)
                                            .font(.system(size: 14))
                                            .foregroundColor(.white.opacity(0.6))
                                    }
                                    
                                    Spacer()
                                    
                                    Button {
                                        onSuggest(song)
                                        dismiss()
                                    } label: {
                                        Text("Suggest")
                                            .font(.system(size: 13, weight: .bold))
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 6)
                                            .background(Color.white.opacity(0.1))
                                            .foregroundColor(.white)
                                            .clipShape(Capsule())
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        .padding(.bottom, 20)
                    }
                }
            }
            .navigationTitle("Suggest a Song")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                        .foregroundColor(.white)
                }
            }
        }
    }
}

// RoomsListView.swift
// SpotifyClone

import SwiftUI

struct RoomsListView: View {
    @EnvironmentObject var player: PlayerViewModel
    @State private var selectedFilter: VibeMood? = nil
    @State private var showCreateRoom = false
    @State private var searchText = ""
    @State private var joinedRoomIDs: Set<UUID> = []
    @State private var userCreatedRooms: [Room] = []
    @State private var showJoinConfirm = false
    @State private var roomToJoin: Room? = nil

    var allRooms: [Room] {
        MockData.rooms + userCreatedRooms
    }

    var filteredRooms: [Room] {
        var result = allRooms

        if let filter = selectedFilter {
            result = result.filter { $0.currentMood == filter }
        }

        if !searchText.isEmpty {
            result = result.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.currentMood.rawValue.localizedCaseInsensitiveContains(searchText) ||
                $0.currentSong.title.localizedCaseInsensitiveContains(searchText) ||
                $0.currentSong.artist.localizedCaseInsensitiveContains(searchText)
            }
        }

        return result
    }

    var liveCount: Int {
        filteredRooms.filter { $0.isLive }.count
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.spotifyBlack.ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 16) {

                        // Hero Banner with Create button
                        heroBanner

                        // Search bar
                        searchBar

                        // Mood Filter chips
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                FilterChip(label: "All", emoji: "🎵", isSelected: selectedFilter == nil) {
                                    withAnimation { selectedFilter = nil }
                                }
                                ForEach(VibeMood.allCases, id: \.rawValue) { mood in
                                    FilterChip(label: mood.rawValue, emoji: mood.emoji, isSelected: selectedFilter == mood) {
                                        withAnimation { selectedFilter = mood }
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }

                        // Live rooms label
                        HStack {
                            Circle().fill(Color.red).frame(width: 7, height: 7)
                            Text("\(liveCount) rooms live now")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(.spotifyLightGray)
                        }
                        .padding(.horizontal)

                        // Room cards
                        if filteredRooms.isEmpty {
                            emptyState
                        } else {
                            LazyVStack(spacing: 14) {
                                ForEach(filteredRooms) { room in
                                    let isJoined = joinedRoomIDs.contains(room.id)

                                    if isJoined {
                                        NavigationLink(destination: RoomDetailView(room: room, onLeave: {
                                            withAnimation { _ = joinedRoomIDs.remove(room.id) }
                                        }).environmentObject(player)) {
                                            RoomRow(room: room, isJoined: true)
                                                .padding(.horizontal)
                                        }
                                        .buttonStyle(.plain)
                                    } else {
                                        Button {
                                            roomToJoin = room
                                            showJoinConfirm = true
                                        } label: {
                                            RoomRow(room: room, isJoined: false)
                                                .padding(.horizontal)
                                        }
                                        .buttonStyle(.plain)
                                    }
                                }
                            }
                        }

                        Spacer(minLength: 100)
                    }
                    .padding(.top, 8)
                }
            }
            .navigationTitle("Vibe Rooms")
            .navigationBarTitleDisplayMode(.large)
            .toolbarColorScheme(.dark, for: .navigationBar)

            .sheet(isPresented: $showCreateRoom) {
                CreateRoomView { newRoom in
                    withAnimation(.spring()) {
                        userCreatedRooms.insert(newRoom, at: 0)
                        _ = joinedRoomIDs.insert(newRoom.id)
                    }
                }
            }
            .alert("Join Room?", isPresented: $showJoinConfirm, presenting: roomToJoin) { room in
                Button("Join") {
                    withAnimation(.spring()) {
                        _ = joinedRoomIDs.insert(room.id)
                    }
                }
                Button("Cancel", role: .cancel) { }
            } message: { room in
                Text("Join \"\(room.name)\" and start listening with \(room.listenerCount) others?")
            }
            .fullScreenCover(isPresented: $player.showNowPlaying) {
                NowPlayingView().environmentObject(player)
            }
        }
    }

    // MARK: - Hero Banner
    private var heroBanner: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 16)
                .fill(LinearGradient(
                    colors: [Color(hex: "6C63FF"), Color(hex: "C026D3"), Color(hex: "FF6B6B")],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .frame(height: 140)

            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("🌐 Listen Together")
                        .font(.system(size: 20, weight: .black))
                        .foregroundColor(.white)
                    Text("Join a Vibe Room and share the moment.")
                        .font(.system(size: 13))
                        .foregroundColor(.white.opacity(0.8))
                }

                Spacer()

                // Create room button in banner
                Button {
                    showCreateRoom = true
                } label: {
                    HStack(spacing: 6) {
                        Image(systemName: "plus")
                            .font(.system(size: 14, weight: .bold))
                        Text("Create")
                            .font(.system(size: 14, weight: .bold))
                    }
                    .foregroundColor(.black)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(Color.white)
                    .clipShape(Capsule())
                }
            }
            .padding(20)
        }
        .padding(.horizontal)
    }

    // MARK: - Search Bar
    private var searchBar: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 15))
                .foregroundColor(.spotifyLightGray)

            TextField("Search rooms...", text: $searchText)
                .font(.system(size: 15))
                .foregroundColor(.white)

            if !searchText.isEmpty {
                Button {
                    searchText = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 16))
                        .foregroundColor(.spotifyLightGray)
                }
            }
        }
        .padding(12)
        .background(Color.spotifyDarkGray)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.horizontal)
    }

    // MARK: - Empty State
    private var emptyState: some View {
        VStack(spacing: 16) {
            Image(systemName: "waveform.badge.magnifyingglass")
                .font(.system(size: 40))
                .foregroundColor(.white.opacity(0.3))
            Text("No rooms found")
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(.white.opacity(0.5))
            Text("Try a different search or create your own room")
                .font(.system(size: 13))
                .foregroundColor(.white.opacity(0.35))

            Button {
                showCreateRoom = true
            } label: {
                HStack(spacing: 6) {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 16))
                    Text("Create Room")
                        .font(.system(size: 14, weight: .semibold))
                }
                .foregroundColor(.black)
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(Color.spotifyGreen)
                .clipShape(Capsule())
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 60)
    }
}

// MARK: - Filter Chip
private struct FilterChip: View {
    let label: String
    let emoji: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 5) {
                Text(emoji).font(.system(size: 14))
                Text(label).font(.system(size: 13, weight: .semibold))
            }
            .foregroundColor(isSelected ? .black : .white)
            .padding(.horizontal, 14)
            .padding(.vertical, 7)
            .background(isSelected ? Color.spotifyGreen : Color.spotifyDarkGray)
            .clipShape(Capsule())
        }
    }
}

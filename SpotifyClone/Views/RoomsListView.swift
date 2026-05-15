// RoomsListView.swift
// SpotifyClone

import SwiftUI

struct RoomsListView: View {
    @EnvironmentObject var player: PlayerViewModel
    @State private var selectedFilter: VibeMood? = nil

    var filteredRooms: [Room] {
        guard let filter = selectedFilter else { return MockData.rooms }
        return MockData.rooms.filter { $0.currentMood == filter }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.spotifyBlack.ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {

                        // Hero Banner
                        heroBanner

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
                            Text("\(filteredRooms.filter { $0.isLive }.count) rooms live now")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(.spotifyLightGray)
                        }
                        .padding(.horizontal)

                        // Room cards
                        LazyVStack(spacing: 14) {
                            ForEach(filteredRooms) { room in
                                NavigationLink(destination: RoomDetailView(room: room).environmentObject(player)) {
                                    RoomRow(room: room)
                                        .padding(.horizontal)
                                }
                                .buttonStyle(.plain)
                            }
                        }

                        // Create Room button
                        Button {
                        } label: {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                    .font(.system(size: 20))
                                Text("Create a Room")
                                    .font(.system(size: 16, weight: .semibold))
                            }
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color.spotifyGreen)
                            .clipShape(Capsule())
                            .padding(.horizontal)
                        }

                        Spacer(minLength: 100)
                    }
                    .padding(.top, 8)
                }
            }
            .navigationTitle("Vibe Rooms")
            .navigationBarTitleDisplayMode(.large)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .fullScreenCover(isPresented: $player.showNowPlaying) {
                NowPlayingView().environmentObject(player)
            }
        }
    }

    private var heroBanner: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 16)
                .fill(LinearGradient(
                    colors: [Color(hex: "6C63FF"), Color(hex: "C026D3"), Color(hex: "FF6B6B")],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .frame(height: 140)

            VStack(alignment: .leading, spacing: 4) {
                Text("🌐 Listen Together")
                    .font(.system(size: 20, weight: .black))
                    .foregroundColor(.white)
                Text("Join a Vibe Room and share the moment.")
                    .font(.system(size: 13))
                    .foregroundColor(.white.opacity(0.8))
            }
            .padding(20)
        }
        .padding(.horizontal)
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

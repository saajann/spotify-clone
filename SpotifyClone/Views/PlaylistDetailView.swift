// PlaylistDetailView.swift
// SpotifyClone

import SwiftUI

struct PlaylistDetailView: View {
    let playlist: Playlist
    @EnvironmentObject var player: PlayerViewModel
    @State private var isFollowing = false

    var body: some View {
        ZStack {
            Color.spotifyBlack.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    // Header
                    ZStack(alignment: .bottom) {
                        LinearGradient(
                            colors: playlist.gradientColors + [Color.spotifyBlack],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(height: 360)

                        VStack(spacing: 12) {
                            // Playlist art
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(LinearGradient(
                                        colors: playlist.gradientColors,
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ))
                                    .frame(width: 200, height: 200)
                                    .shadow(color: playlist.gradientColors.first!.opacity(0.6), radius: 20)

                                if playlist.type == .liked {
                                    Image(systemName: "heart.fill")
                                        .font(.system(size: 60))
                                        .foregroundColor(.white)
                                } else {
                                    Image(systemName: "music.note.list")
                                        .font(.system(size: 55))
                                        .foregroundColor(.white.opacity(0.8))
                                }
                            }
                            .padding(.top, 60)

                            Text(playlist.name)
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)

                            Text(playlist.description)
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.7))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 40)

                            HStack(spacing: 6) {
                                if playlist.owner == "Spotify" {
                                    Image(systemName: "checkmark.seal.fill")
                                        .foregroundColor(.spotifyGreen)
                                        .font(.system(size: 12))
                                }
                                Text(playlist.owner)
                                    .font(.system(size: 13, weight: .semibold))
                                    .foregroundColor(.white)

                                Text("·")
                                    .foregroundColor(.white.opacity(0.5))

                                Text("\(playlist.tracks.count) songs")
                                    .font(.system(size: 13))
                                    .foregroundColor(.white.opacity(0.7))

                                if playlist.followerCount > 0 {
                                    Text("·")
                                        .foregroundColor(.white.opacity(0.5))
                                    Text(formatCount(playlist.followerCount))
                                        .font(.system(size: 13))
                                        .foregroundColor(.white.opacity(0.7))
                                }
                            }
                        }
                        .padding(.bottom, 20)
                    }

                    // Action bar
                    HStack(spacing: 16) {
                        if playlist.type != .liked {
                            Button {
                                isFollowing.toggle()
                            } label: {
                                Text(isFollowing ? "Following" : "Follow")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(isFollowing ? .spotifyGreen : .white)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 8)
                                    .overlay(Capsule().stroke(isFollowing ? Color.spotifyGreen : Color.white.opacity(0.5), lineWidth: 1))
                            }
                        }

                        Button { } label: {
                            Image(systemName: "ellipsis")
                                .font(.system(size: 20))
                                .foregroundColor(.white.opacity(0.7))
                        }

                        Spacer()

                        Button {
                            if let first = playlist.tracks.first { player.play(first) }
                        } label: {
                            Image(systemName: "shuffle")
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                        }

                        PlayPauseButton(isPlaying: Binding(
                            get: { player.isPlaying && playlist.tracks.contains(where: { $0.id == player.currentSong?.id }) },
                            set: { _ in player.togglePlayPause() }
                        ), size: 52)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)

                    // Track list
                    ForEach(playlist.tracks) { song in
                        SongRow(song: song, showAlbum: true)
                            .padding(.horizontal, 16)
                        Divider()
                            .background(Color.spotifyMidGray.opacity(0.3))
                    }

                    Spacer(minLength: 100)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }

    private func formatCount(_ n: Int) -> String {
        if n >= 1_000_000 {
            return String(format: "%.1fM likes", Double(n) / 1_000_000)
        }
        return "\(n / 1000)K likes"
    }
}

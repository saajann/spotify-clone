// AlbumDetailView.swift
// SpotifyClone

import SwiftUI

struct AlbumDetailView: View {
    let album: Album
    @EnvironmentObject var player: PlayerViewModel
    @State private var isFollowing = false
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack(alignment: .top) {
            Color.spotifyBlack.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    // Header
                    ZStack(alignment: .bottom) {
                        LinearGradient(
                            colors: album.gradientColors + [Color.spotifyBlack],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(height: 360)

                        VStack(spacing: 12) {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(LinearGradient(colors: album.gradientColors, startPoint: .topLeading, endPoint: .bottomTrailing))
                                .frame(width: 200, height: 200)
                                .shadow(color: album.dominantColor.opacity(0.6), radius: 20)
                                .overlay(
                                    Image(systemName: "music.note")
                                        .font(.system(size: 60))
                                        .foregroundColor(.white.opacity(0.3))
                                )
                                .padding(.top, 60)

                            Text(album.title)
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)

                            HStack(spacing: 6) {
                                Circle()
                                    .fill(LinearGradient(colors: album.gradientColors, startPoint: .leading, endPoint: .trailing))
                                    .frame(width: 20, height: 20)
                                Text(album.artist)
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.white)
                            }

                            Text("Album · \(album.year) · \(album.trackCount) songs")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.6))
                        }
                        .padding(.bottom, 20)
                    }

                    // Actions
                    HStack(spacing: 20) {
                        Button {
                            isFollowing.toggle()
                        } label: {
                            Text(isFollowing ? "Following" : "Follow")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(isFollowing ? .spotifyGreen : .white)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 8)
                                .overlay(
                                    Capsule().stroke(isFollowing ? Color.spotifyGreen : Color.white.opacity(0.5), lineWidth: 1)
                                )
                        }

                        Button { } label: {
                            Image(systemName: "ellipsis")
                                .font(.system(size: 20))
                                .foregroundColor(.white.opacity(0.7))
                        }

                        Spacer()

                        Button {
                            if let first = album.tracks.first { player.play(first) }
                        } label: {
                            Image(systemName: "shuffle")
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                        }

                        PlayPauseButton(isPlaying: Binding(
                            get: { player.isPlaying && album.tracks.contains(where: { $0.id == player.currentSong?.id }) },
                            set: { _ in player.togglePlayPause() }
                        ), size: 52)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)

                    // Track list
                    ForEach(album.tracks.indices, id: \.self) { i in
                        SongRow(song: album.tracks[i], trackNumber: i + 1)
                            .padding(.horizontal, 16)
                        Divider()
                            .background(Color.spotifyMidGray.opacity(0.3))
                            .padding(.leading, 56)
                    }

                    // Footer info
                    VStack(alignment: .leading, spacing: 4) {
                        Text("\(album.year)")
                            .font(.caption)
                            .foregroundColor(.spotifyLightGray)
                        Text("\(album.trackCount) songs")
                            .font(.caption)
                            .foregroundColor(.spotifyLightGray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 20)

                    Spacer(minLength: 100)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }
}

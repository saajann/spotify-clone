// ArtistView.swift
// SpotifyClone

import SwiftUI

struct ArtistView: View {
    let artist: Artist
    @EnvironmentObject var player: PlayerViewModel
    @State private var isFollowing = false
    @State private var scrollOffset: CGFloat = 0

    var body: some View {
        ZStack(alignment: .top) {
            Color.spotifyBlack.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    // Hero header
                    ZStack(alignment: .bottomLeading) {
                        LinearGradient(
                            colors: artist.gradientColors + [Color.spotifyBlack],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(height: 300)
                        .overlay(
                            Circle()
                                .fill(LinearGradient(colors: artist.gradientColors, startPoint: .topLeading, endPoint: .bottomTrailing))
                                .frame(width: 180, height: 180)
                                .overlay(
                                    Text(String(artist.name.prefix(1)))
                                        .font(.system(size: 72, weight: .black))
                                        .foregroundColor(.white)
                                )
                                .shadow(color: artist.gradientColors.first!.opacity(0.5), radius: 30)
                        )

                        VStack(alignment: .leading, spacing: 4) {
                            HStack(spacing: 6) {
                                if artist.verified {
                                    Image(systemName: "checkmark.seal.fill")
                                        .foregroundColor(.spotifyGreen)
                                        .font(.system(size: 14))
                                    Text("Verified Artist")
                                        .font(.system(size: 12, weight: .semibold))
                                        .foregroundColor(.spotifyGreen)
                                }
                            }
                            Text(artist.name)
                                .font(.system(size: 36, weight: .black))
                                .foregroundColor(.white)

                            Text(artist.formattedMonthlyListeners)
                                .font(.system(size: 13))
                                .foregroundColor(.white.opacity(0.7))
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 20)
                    }

                    // Action bar
                    HStack(spacing: 16) {
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

                        Button { } label: {
                            Image(systemName: "ellipsis")
                                .font(.system(size: 20))
                                .foregroundColor(.white.opacity(0.7))
                        }

                        Spacer()

                        Button {
                            if let first = artist.topTracks.first { player.play(first) }
                        } label: {
                            Image(systemName: "shuffle")
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                        }

                        PlayPauseButton(isPlaying: Binding(
                            get: { player.isPlaying && artist.topTracks.contains(where: { $0.id == player.currentSong?.id }) },
                            set: { _ in player.togglePlayPause() }
                        ), size: 52)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 16)

                    // Popular tracks
                    sectionTitle("Popular")
                    ForEach(artist.topTracks.prefix(5).indices, id: \.self) { i in
                        SongRow(song: artist.topTracks[i], showAlbum: true)
                            .padding(.horizontal, 16)
                    }

                    // Bio
                    sectionTitle("About")
                    VStack(alignment: .leading, spacing: 12) {
                        Text(artist.bio)
                            .font(.system(size: 14))
                            .foregroundColor(.spotifyLightGray)
                            .lineSpacing(5)

                        HStack(spacing: 20) {
                            VStack(spacing: 2) {
                                Text(artist.formattedFollowers)
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(.white)
                                Text("Followers")
                                    .font(.caption)
                                    .foregroundColor(.spotifyLightGray)
                            }
                            VStack(spacing: 2) {
                                Text(artist.formattedMonthlyListeners.components(separatedBy: " ").first ?? "")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(.white)
                                Text("Monthly Listeners")
                                    .font(.caption)
                                    .foregroundColor(.spotifyLightGray)
                            }
                        }
                        .padding(.top, 8)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 100)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }

    private func sectionTitle(_ title: String) -> some View {
        Text(title)
            .font(.system(size: 22, weight: .bold))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
            .padding(.top, 24)
            .padding(.bottom, 12)
    }
}

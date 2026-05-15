// MiniPlayer.swift
// SpotifyClone

import SwiftUI

struct MiniPlayer: View {
    @EnvironmentObject var player: PlayerViewModel
    @State private var dragOffset: CGFloat = 0

    var body: some View {
        if let song = player.currentSong {
            VStack(spacing: 0) {
                // Progress line
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .fill(Color.spotifyMidGray)
                            .frame(height: 2)
                        Rectangle()
                            .fill(Color.spotifyGreen)
                            .frame(width: geo.size.width * player.progress, height: 2)
                    }
                }
                .frame(height: 2)

                HStack(spacing: 14) {
                    // Album art
                    RoundedRectangle(cornerRadius: 6)
                        .fill(LinearGradient(
                            colors: song.albumGradient,
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        .frame(width: 44, height: 44)
                        .shadow(color: song.dominantColor.opacity(0.4), radius: 6, x: 0, y: 2)

                    // Song info
                    VStack(alignment: .leading, spacing: 2) {
                        Text(song.title)
                            .font(.subheadline.weight(.semibold))
                            .foregroundColor(.spotifyWhite)
                            .lineLimit(1)
                        Text(song.artist)
                            .font(.caption)
                            .foregroundColor(.spotifyLightGray)
                            .lineLimit(1)
                    }

                    Spacer()

                    // Like
                    Button {
                        // TODO: toggle like
                    } label: {
                        Image(systemName: song.isLiked ? "heart.fill" : "heart")
                            .foregroundColor(song.isLiked ? .spotifyGreen : .spotifyLightGray)
                            .font(.system(size: 20))
                    }
                    .padding(.trailing, 4)

                    // Play/Pause
                    Button {
                        player.togglePlayPause()
                    } label: {
                        Image(systemName: player.isPlaying ? "pause.fill" : "play.fill")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.spotifyWhite)
                    }
                    .padding(.trailing, 4)

                    // Next
                    Button {
                        player.next()
                    } label: {
                        Image(systemName: "forward.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.spotifyWhite)
                    }
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
            }
            .background(.ultraThinMaterial)
            .background(
                LinearGradient(
                    colors: [song.dominantColor.opacity(0.25), Color.spotifyDarkGray],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal, 8)
            .padding(.bottom, 4)
            .onTapGesture {
                player.showNowPlaying = true
            }
            .gesture(
                DragGesture(minimumDistance: 20)
                    .onEnded { value in
                        if value.translation.width < -60 { player.next() }
                        if value.translation.width > 60  { player.previous() }
                    }
            )
        }
    }
}

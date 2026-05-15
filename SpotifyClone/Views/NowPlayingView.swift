// NowPlayingView.swift
// SpotifyClone

import SwiftUI

struct NowPlayingView: View {
    @EnvironmentObject var player: PlayerViewModel
    @Environment(\.dismiss) var dismiss
    @State private var showQueue = false

    var body: some View {
        ZStack {
            // Dynamic background
            if let song = player.currentSong {
                LinearGradient(
                    colors: [song.dominantColor.opacity(0.85), Color.spotifyBlack],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            } else {
                Color.spotifyBlack.ignoresSafeArea()
            }

            VStack(spacing: 0) {
                // Top bar
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.down")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                    }

                    Spacer()

                    VStack(spacing: 2) {
                        Text("PLAYING FROM PLAYLIST")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(.white.opacity(0.7))
                        Text("Liked Songs")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(.white)
                    }

                    Spacer()

                    Button { } label: {
                        Image(systemName: "ellipsis")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 16)

                Spacer()

                // Album Art — Large
                if let song = player.currentSong {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(LinearGradient(
                            colors: song.albumGradient,
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        .frame(width: player.isPlaying ? 300 : 260, height: player.isPlaying ? 300 : 260)
                        .shadow(color: song.dominantColor.opacity(0.6), radius: 30, x: 0, y: 15)
                        .animation(.spring(response: 0.4, dampingFraction: 0.7), value: player.isPlaying)
                        .padding(.horizontal, 24)
                }

                Spacer()

                // Song info + actions
                if let song = player.currentSong {
                    HStack(alignment: .center) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(song.title)
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(.white)
                                .lineLimit(1)
                            Text(song.artist)
                                .font(.system(size: 16))
                                .foregroundColor(.white.opacity(0.7))
                                .lineLimit(1)
                        }
                        Spacer()
                        Button { } label: {
                            Image(systemName: song.isLiked ? "heart.fill" : "heart")
                                .font(.system(size: 24))
                                .foregroundColor(song.isLiked ? .spotifyGreen : .white)
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 20)

                    // Progress Bar
                    ProgressBarView(progress: $player.progress, duration: song.duration, accentColor: .white)
                        .padding(.horizontal, 24)
                        .padding(.bottom, 24)

                    // Controls
                    HStack(spacing: 0) {
                        Button {
                            player.isShuffled.toggle()
                        } label: {
                            Image(systemName: "shuffle")
                                .font(.system(size: 20))
                                .foregroundColor(player.isShuffled ? .spotifyGreen : .white.opacity(0.7))
                        }
                        .frame(maxWidth: .infinity)

                        Button { player.previous() } label: {
                            Image(systemName: "backward.fill")
                                .font(.system(size: 28))
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity)

                        PlayPauseButton(isPlaying: $player.isPlaying, size: 68)
                            .frame(maxWidth: .infinity)

                        Button { player.next() } label: {
                            Image(systemName: "forward.fill")
                                .font(.system(size: 28))
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity)

                        Button {
                            player.repeatMode.cycle()
                        } label: {
                            Image(systemName: player.repeatMode.icon)
                                .font(.system(size: 20))
                                .foregroundColor(player.repeatMode.isActive ? .spotifyGreen : .white.opacity(0.7))
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 24)

                    // Volume Bar
                    HStack(spacing: 10) {
                        Image(systemName: "speaker.fill")
                            .font(.system(size: 14))
                            .foregroundColor(.white.opacity(0.6))

                        Slider(value: $player.volume)
                            .tint(.white)

                        Image(systemName: "speaker.wave.3.fill")
                            .font(.system(size: 14))
                            .foregroundColor(.white.opacity(0.6))
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 24)

                    // Bottom actions
                    HStack {
                        Button { } label: {
                            Image(systemName: "airplayaudio")
                                .font(.system(size: 22))
                                .foregroundColor(.white.opacity(0.8))
                        }
                        Spacer()
                        Button { } label: {
                            Image(systemName: "square.and.arrow.up")
                                .font(.system(size: 22))
                                .foregroundColor(.white.opacity(0.8))
                        }
                        Spacer()
                        Button { showQueue.toggle() } label: {
                            Image(systemName: "list.bullet")
                                .font(.system(size: 22))
                                .foregroundColor(showQueue ? .spotifyGreen : .white.opacity(0.8))
                        }
                    }
                    .padding(.horizontal, 40)
                    .padding(.bottom, 36)
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

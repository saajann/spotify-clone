// SongRow.swift
// SpotifyClone

import SwiftUI
import Combine

struct SongRow: View {
    let song: Song
    var showAlbum: Bool = false
    var trackNumber: Int? = nil
    @EnvironmentObject var player: PlayerViewModel

    var isCurrentSong: Bool { player.currentSong?.id == song.id }

    var body: some View {
        Button {
            player.play(song)
        } label: {
            HStack(spacing: 14) {
                // Track number or album art
                if let num = trackNumber {
                    Text("\(num)")
                        .font(.subheadline)
                        .foregroundColor(isCurrentSong ? .spotifyGreen : .spotifyLightGray)
                        .frame(width: 24, alignment: .center)
                } else {
                    ZStack {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(LinearGradient(
                                colors: song.albumGradient,
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ))
                            .frame(width: 46, height: 46)

                        if isCurrentSong && player.isPlaying {
                            EqualizerBarsView()
                        }
                    }
                }

                // Info
                VStack(alignment: .leading, spacing: 3) {
                    HStack(spacing: 4) {
                        Text(song.title)
                            .font(.body.weight(isCurrentSong ? .semibold : .regular))
                            .foregroundColor(isCurrentSong ? .spotifyGreen : .spotifyWhite)
                            .lineLimit(1)

                        if song.isExplicit {
                            Text("E")
                                .font(.system(size: 9, weight: .bold))
                                .foregroundColor(.spotifyLightGray)
                                .padding(.horizontal, 3)
                                .padding(.vertical, 1)
                                .background(Color.spotifyLightGray.opacity(0.3))
                                .clipShape(RoundedRectangle(cornerRadius: 2))
                        }
                    }
                    Text(showAlbum ? "\(song.artist) • \(song.album)" : song.artist)
                        .font(.caption)
                        .foregroundColor(.spotifyLightGray)
                        .lineLimit(1)
                }

                Spacer()

                // Duration
                Text(song.formattedDuration)
                    .font(.caption)
                    .foregroundColor(.spotifyLightGray)

                // More
                Image(systemName: "ellipsis")
                    .font(.system(size: 16))
                    .foregroundColor(.spotifyLightGray)
            }
            .padding(.vertical, 6)
        }
        .buttonStyle(.plain)
    }
}

// Animated equalizer bars for currently playing
struct EqualizerBarsView: View {
    @State private var heights: [CGFloat] = [6, 12, 8, 14, 6]

    let timer = Timer.publish(every: 0.35, on: .main, in: .common).autoconnect()

    var body: some View {
        HStack(spacing: 2) {
            ForEach(0..<5) { i in
                RoundedRectangle(cornerRadius: 1)
                    .fill(Color.spotifyGreen)
                    .frame(width: 3, height: heights[i])
                    .animation(.easeInOut(duration: 0.35), value: heights[i])
            }
        }
        .onReceive(timer) { _ in
            heights = (0..<5).map { _ in CGFloat.random(in: 4...16) }
        }
    }
}

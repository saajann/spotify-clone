// CardView.swift
// SpotifyClone

import SwiftUI

struct CardView: View {
    let song: Song
    @EnvironmentObject var player: PlayerViewModel

    var body: some View {
        Button {
            player.play(song)
        } label: {
            VStack(alignment: .leading, spacing: 8) {
                // Album art square
                ZStack(alignment: .bottomTrailing) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LinearGradient(
                            colors: song.albumGradient,
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        .frame(width: 140, height: 140)
                        .shadow(color: song.dominantColor.opacity(0.5), radius: 10, x: 0, y: 4)

                    // Play button overlay when playing
                    if player.currentSong?.id == song.id && player.isPlaying {
                        Circle()
                            .fill(Color.spotifyGreen)
                            .frame(width: 36, height: 36)
                            .overlay(
                                Image(systemName: "pause.fill")
                                    .font(.system(size: 13, weight: .bold))
                                    .foregroundColor(.black)
                            )
                            .shadow(color: .black.opacity(0.3), radius: 6)
                            .padding(8)
                    }
                }

                Text(song.title)
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(.spotifyWhite)
                    .lineLimit(1)
                    .frame(width: 140, alignment: .leading)

                Text(song.artist)
                    .font(.caption)
                    .foregroundColor(.spotifyLightGray)
                    .lineLimit(1)
                    .frame(width: 140, alignment: .leading)
            }
        }
        .buttonStyle(.plain)
    }
}

struct AlbumCard: View {
    let album: Album
    @EnvironmentObject var player: PlayerViewModel

    var body: some View {
        NavigationLink(destination: AlbumDetailView(album: album)) {
            VStack(alignment: .leading, spacing: 8) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(LinearGradient(
                        colors: album.gradientColors,
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                    .frame(width: 140, height: 140)
                    .shadow(color: album.dominantColor.opacity(0.4), radius: 8, x: 0, y: 3)

                Text(album.title)
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(.spotifyWhite)
                    .lineLimit(1)
                    .frame(width: 140, alignment: .leading)

                Text(album.artist)
                    .font(.caption)
                    .foregroundColor(.spotifyLightGray)
                    .lineLimit(1)
                    .frame(width: 140, alignment: .leading)
            }
        }
        .buttonStyle(.plain)
    }
}

struct PlaylistCard: View {
    let playlist: Playlist

    var body: some View {
        NavigationLink(destination: PlaylistDetailView(playlist: playlist)) {
            VStack(alignment: .leading, spacing: 8) {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LinearGradient(
                            colors: playlist.gradientColors,
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        .frame(width: 140, height: 140)
                        .shadow(color: playlist.gradientColors.first!.opacity(0.4), radius: 8, x: 0, y: 3)

                    if playlist.type == .liked {
                        Image(systemName: "heart.fill")
                            .font(.system(size: 44))
                            .foregroundColor(.white)
                    } else {
                        Image(systemName: "music.note.list")
                            .font(.system(size: 40))
                            .foregroundColor(.white.opacity(0.8))
                    }
                }

                Text(playlist.name)
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(.spotifyWhite)
                    .lineLimit(1)
                    .frame(width: 140, alignment: .leading)

                Text(playlist.owner == "Spotify" ? "By Spotify" : playlist.description)
                    .font(.caption)
                    .foregroundColor(.spotifyLightGray)
                    .lineLimit(1)
                    .frame(width: 140, alignment: .leading)
            }
        }
        .buttonStyle(.plain)
    }
}

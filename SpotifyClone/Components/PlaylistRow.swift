// PlaylistRow.swift
// SpotifyClone

import SwiftUI

struct PlaylistRow: View {
    let playlist: Playlist

    var body: some View {
        NavigationLink(destination: PlaylistDetailView(playlist: playlist)) {
            HStack(spacing: 14) {
                ZStack {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(LinearGradient(
                            colors: playlist.gradientColors,
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        .frame(width: 52, height: 52)

                    if playlist.type == .liked {
                        Image(systemName: "heart.fill")
                            .font(.title3)
                            .foregroundColor(.white)
                    } else {
                        Image(systemName: "music.note.list")
                            .font(.title3)
                            .foregroundColor(.white.opacity(0.85))
                    }
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(playlist.name)
                        .font(.body.weight(.medium))
                        .foregroundColor(.spotifyWhite)
                        .lineLimit(1)

                    HStack(spacing: 4) {
                        if playlist.owner == "Spotify" {
                            Image(systemName: "checkmark.seal.fill")
                                .font(.system(size: 10))
                                .foregroundColor(.spotifyGreen)
                        }
                        Text(playlist.type == .liked ? "\(playlist.tracks.count) songs" : playlist.owner)
                            .font(.caption)
                            .foregroundColor(.spotifyLightGray)
                    }
                }
                Spacer()
            }
            .padding(.vertical, 4)
        }
        .buttonStyle(.plain)
    }
}

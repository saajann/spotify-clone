//
//  SongRow.swift
//  SpotifyClone
//
//  Created by Saajan Saini on 15/05/26.
//

import SwiftUI

struct SongRow: View {
    let song: Song

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: song.albumArt)
                .font(.title2)
                .foregroundColor(.spotifyWhite)
                .frame(width: 44, height: 44)
                .background(Color.spotifyDarkGray)
                .clipShape(RoundedRectangle(cornerRadius: 4))

            VStack(alignment: .leading, spacing: 2) {
                Text(song.title)
                    .font(.body)
                    .foregroundColor(.spotifyWhite)
                Text(song.artist)
                    .font(.caption)
                    .foregroundColor(.spotifyLightGray)
            }
            Spacer()
        }
        .padding(.vertical, 4)
    }
}

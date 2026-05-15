//
//  CardView.swift
//  SpotifyClone
//
//  Created by Saajan Saini on 15/05/26.
//

import SwiftUI

struct CardView: View {
    let song: Song

    var body: some View {
        VStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 8)
                .fill(LinearGradient(
                    gradient: Gradient(colors: [Color.spotifyDarkGray, Color.spotifyDarkGray.opacity(0.6)]),
                    startPoint: .top,
                    endPoint: .bottom
                ))
                .frame(width: 130, height: 130)
                .overlay(
                    Image(systemName: song.albumArt)
                        .font(.largeTitle)
                        .foregroundColor(.spotifyWhite.opacity(0.7))
                )
            Text(song.title)
                .font(.subheadline.bold())
                .foregroundColor(.spotifyWhite)
                .lineLimit(1)
                .frame(width: 130, alignment: .leading)
            Text(song.artist)
                .font(.caption)
                .foregroundColor(.spotifyLightGray)
                .lineLimit(1)
                .frame(width: 130, alignment: .leading)
        }
    }
}

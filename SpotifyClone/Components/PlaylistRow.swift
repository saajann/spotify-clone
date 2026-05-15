//
//  PlaylistRow.swift
//  SpotifyClone
//
//  Created by Saajan Saini on 15/05/26.
//

import SwiftUI

struct PlaylistRow: View {
    let title: String

    var body: some View {
        HStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.spotifyDarkGray)
                .frame(width: 44, height: 44)
                .overlay(
                    Image(systemName: "music.note.list")
                        .foregroundColor(.spotifyWhite)
                )
            Text(title)
                .font(.body)
                .foregroundColor(.spotifyWhite)
            Spacer()
        }
        .padding(.vertical, 4)
    }
}

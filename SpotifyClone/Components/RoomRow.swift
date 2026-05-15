//
//  RoomRow.swift
//  SpotifyClone
//
//  Created by Saajan Saini on 15/05/26.
//

import SwiftUI

struct RoomRow: View {
    let room: Room

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(room.name)
                    .font(.headline)
                    .foregroundColor(.spotifyWhite)
                Spacer()
                Text(room.mood.uppercased())
                    .font(.caption.bold())
                    .foregroundColor(.spotifyGreen)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 2)
                    .background(Color.spotifyGreen.opacity(0.15))
                    .clipShape(Capsule())
            }

            HStack {
                Image(systemName: "music.note")
                    .font(.caption)
                    .foregroundColor(.spotifyGreen)
                Text(room.currentSong.title)
                    .font(.subheadline)
                    .foregroundColor(.spotifyLightGray)
                Text("•")
                    .foregroundColor(.spotifyLightGray)
                Text(room.currentSong.artist)
                    .font(.subheadline)
                    .foregroundColor(.spotifyLightGray)
            }

            HStack {
                Image(systemName: "person.2.fill")
                    .font(.caption)
                    .foregroundColor(.spotifyLightGray)
                Text("\(room.users.count) people")
                    .font(.caption)
                    .foregroundColor(.spotifyLightGray)
            }
        }
        .padding(.vertical, 8)
    }
}

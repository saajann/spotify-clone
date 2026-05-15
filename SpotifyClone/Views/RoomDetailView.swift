//
//  RoomDetailView.swift
//  SpotifyClone
//
//  Created by Saajan Saini on 15/05/26.
//

import SwiftUI

struct RoomDetailView: View {
    let room: Room
    @State private var isPlaying = false

    var body: some View {
        ZStack {
            Color.spotifyBlack.ignoresSafeArea()

            VStack(spacing: 32) {
                VStack(spacing: 8) {
                    Text(room.name)
                        .font(.largeTitle.bold())
                        .foregroundColor(.spotifyWhite)

                    Text(room.mood.capitalized)
                        .font(.headline)
                        .foregroundColor(.spotifyGreen)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 4)
                        .background(Color.spotifyGreen.opacity(0.15))
                        .clipShape(Capsule())
                }

                VStack(spacing: 4) {
                    Text("Now Playing")
                        .font(.caption)
                        .foregroundColor(.spotifyLightGray)

                    Text(room.currentSong.title)
                        .font(.title3.bold())
                        .foregroundColor(.spotifyWhite)

                    Text(room.currentSong.artist)
                        .font(.subheadline)
                        .foregroundColor(.spotifyLightGray)
                }

                PlayPauseButton(isPlaying: $isPlaying)

                VStack(alignment: .leading, spacing: 12) {
                    Text("People in the room")
                        .font(.headline)
                        .foregroundColor(.spotifyWhite)

                    ForEach(room.users, id: \.self) { user in
                        HStack {
                            Image(systemName: "person.circle.fill")
                                .foregroundColor(.spotifyLightGray)
                            Text(user)
                                .foregroundColor(.spotifyWhite)
                            Spacer()
                        }
                        .padding(.vertical, 4)
                    }
                }
                .padding(.horizontal)

                Spacer()
            }
            .padding(.top, 40)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

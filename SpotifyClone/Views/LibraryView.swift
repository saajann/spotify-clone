//
//  LibraryView.swift
//  SpotifyClone
//
//  Created by Saajan Saini on 15/05/26.
//

import SwiftUI

struct LibraryView: View {
    private let playlists = [
        "Liked Songs",
        "Daily Mix 1",
        "Discover Weekly",
        "Chill Vibes",
        "Workout Energy",
        "Focus Flow"
    ]

    var body: some View {
        NavigationStack {
            List(playlists, id: \.self) { playlist in
                PlaylistRow(title: playlist)
                    .listRowBackground(Color.spotifyBlack)
            }
            .listStyle(.plain)
            .background(Color.spotifyBlack)
            .navigationTitle("Your Library")
            .navigationBarTitleDisplayMode(.large)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
    }
}

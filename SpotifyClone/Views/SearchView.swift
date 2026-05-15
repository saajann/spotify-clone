//
//  SearchView.swift
//  SpotifyClone
//
//  Created by Saajan Saini on 15/05/26.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    private let allSongs = MockData.songs

    var filteredSongs: [Song] {
        if searchText.isEmpty { return allSongs }
        return allSongs.filter {
            $0.title.localizedCaseInsensitiveContains(searchText) ||
            $0.artist.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        NavigationStack {
            List(filteredSongs) { song in
                SongRow(song: song)
                    .listRowBackground(Color.spotifyBlack)
            }
            .listStyle(.plain)
            .background(Color.spotifyBlack)
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Artists, songs, or podcasts")
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.large)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
    }
}

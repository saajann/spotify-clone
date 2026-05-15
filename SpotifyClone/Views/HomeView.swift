//
//  HomeView.swift
//  SpotifyClone
//
//  Created by Saajan Saini on 15/05/26.
//

import SwiftUI

struct HomeView: View {
    private let recentSongs = Array(MockData.songs.prefix(6))
    private let madeForYouSongs = Array(MockData.songs.shuffled().prefix(6))

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    sectionHeader(title: "Recently played")
                    horizontalCards(songs: recentSongs)

                    sectionHeader(title: "Made for you")
                    horizontalCards(songs: madeForYouSongs)
                }
                .padding(.top)
            }
            .background(Color.spotifyBlack)
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.large)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
    }

    private func sectionHeader(title: String) -> some View {
        Text(title)
            .font(.title3.bold())
            .foregroundColor(.spotifyWhite)
            .padding(.horizontal)
    }

    private func horizontalCards(songs: [Song]) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(songs) { song in
                    CardView(song: song)
                }
            }
            .padding(.horizontal)
        }
    }
}

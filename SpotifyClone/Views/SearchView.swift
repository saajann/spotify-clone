// SearchView.swift
// SpotifyClone

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @State private var isSearchFocused = false
    @EnvironmentObject var player: PlayerViewModel

    private let allSongs = MockData.songs
    private let categories = MockData.searchCategories

    var filteredSongs: [Song] {
        if searchText.isEmpty { return [] }
        return allSongs.filter {
            $0.title.localizedCaseInsensitiveContains(searchText) ||
            $0.artist.localizedCaseInsensitiveContains(searchText) ||
            $0.album.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.spotifyBlack.ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {

                        if searchText.isEmpty {
                            // Browse categories
                            Text("Browse all")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.spotifyWhite)
                                .padding(.horizontal)

                            LazyVGrid(
                                columns: [GridItem(.flexible()), GridItem(.flexible())],
                                spacing: 12
                            ) {
                                ForEach(categories, id: \.name) { cat in
                                    CategoryCard(name: cat.name, colors: cat.colors)
                                }
                            }
                            .padding(.horizontal)
                        } else {
                            // Search results
                            if filteredSongs.isEmpty {
                                VStack(spacing: 12) {
                                    Image(systemName: "magnifyingglass")
                                        .font(.system(size: 44))
                                        .foregroundColor(.spotifyLightGray)
                                    Text("No results for \"\(searchText)\"")
                                        .font(.headline)
                                        .foregroundColor(.spotifyWhite)
                                    Text("Check the spelling or try different keywords.")
                                        .font(.subheadline)
                                        .foregroundColor(.spotifyLightGray)
                                        .multilineTextAlignment(.center)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.top, 60)
                            } else {
                                Text("Songs")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.spotifyWhite)
                                    .padding(.horizontal)

                                ForEach(filteredSongs) { song in
                                    SongRow(song: song, showAlbum: true)
                                        .padding(.horizontal)
                                }
                            }
                        }

                        Spacer(minLength: 100)
                    }
                    .padding(.top, 12)
                }
            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.large)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .searchable(
                text: $searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "What do you want to listen to?"
            )
            .fullScreenCover(isPresented: $player.showNowPlaying) {
                NowPlayingView().environmentObject(player)
            }
        }
    }
}

// LibraryView.swift
// SpotifyClone

import SwiftUI

struct LibraryView: View {
    @State private var selectedFilter = 0
    @State private var searchText = ""
    @EnvironmentObject var player: PlayerViewModel

    let filters = ["Playlists", "Albums", "Artists", "Podcasts"]

    var body: some View {
        NavigationStack {
            ZStack {
                Color.spotifyBlack.ignoresSafeArea()

                VStack(spacing: 0) {
                    // Filter chips
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(filters.indices, id: \.self) { i in
                                Button {
                                    withAnimation(.easeInOut(duration: 0.2)) { selectedFilter = i }
                                } label: {
                                    Text(filters[i])
                                        .font(.system(size: 13, weight: .semibold))
                                        .foregroundColor(selectedFilter == i ? .black : .white)
                                        .padding(.horizontal, 14)
                                        .padding(.vertical, 7)
                                        .background(selectedFilter == i ? Color.spotifyWhite : Color.spotifyDarkGray)
                                        .clipShape(Capsule())
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 12)
                    }

                    ScrollView(showsIndicators: false) {
                        LazyVStack(spacing: 0) {
                            if selectedFilter == 0 {
                                playlistsSection
                            } else if selectedFilter == 1 {
                                albumsSection
                            } else if selectedFilter == 2 {
                                artistsSection
                            } else {
                                podcastsSection
                            }
                        }
                        .padding(.bottom, 100)
                    }
                }
            }
            .navigationTitle("Your Library")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(.spotifyWhite)
                            .font(.system(size: 22))
                    }
                }
            }
            .toolbarColorScheme(.dark, for: .navigationBar)
            .fullScreenCover(isPresented: $player.showNowPlaying) {
                NowPlayingView().environmentObject(player)
            }
        }
    }

    // MARK: Sections
    private var playlistsSection: some View {
        ForEach(MockData.playlists) { playlist in
            PlaylistRow(playlist: playlist)
                .padding(.horizontal)
                .padding(.vertical, 2)
        }
    }

    private var albumsSection: some View {
        ForEach(MockData.albums) { album in
            NavigationLink(destination: AlbumDetailView(album: album)) {
                HStack(spacing: 14) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(LinearGradient(colors: album.gradientColors, startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(width: 52, height: 52)
                    VStack(alignment: .leading, spacing: 4) {
                        Text(album.title)
                            .font(.body.weight(.medium))
                            .foregroundColor(.spotifyWhite)
                        Text("\(album.artist) · \(album.year)")
                            .font(.caption)
                            .foregroundColor(.spotifyLightGray)
                    }
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.vertical, 6)
            }
            .buttonStyle(.plain)
        }
    }

    private var artistsSection: some View {
        ForEach(MockData.artists) { artist in
            NavigationLink(destination: ArtistView(artist: artist)) {
                HStack(spacing: 14) {
                    Circle()
                        .fill(LinearGradient(colors: artist.gradientColors, startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(width: 52, height: 52)
                        .overlay(
                            Text(String(artist.name.prefix(1)))
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                        )
                    VStack(alignment: .leading, spacing: 4) {
                        Text(artist.name)
                            .font(.body.weight(.medium))
                            .foregroundColor(.spotifyWhite)
                        HStack(spacing: 4) {
                            if artist.verified {
                                Image(systemName: "checkmark.seal.fill")
                                    .font(.system(size: 10))
                                    .foregroundColor(.spotifyGreen)
                            }
                            Text("Artist")
                                .font(.caption)
                                .foregroundColor(.spotifyLightGray)
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.vertical, 6)
            }
            .buttonStyle(.plain)
        }
    }

    private var podcastsSection: some View {
        ForEach(MockData.podcasts) { podcast in
            HStack(spacing: 14) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(LinearGradient(colors: podcast.gradientColors, startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 52, height: 52)
                    .overlay(
                        Image(systemName: "mic.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                    )
                VStack(alignment: .leading, spacing: 4) {
                    Text(podcast.title)
                        .font(.body.weight(.medium))
                        .foregroundColor(.spotifyWhite)
                    Text(podcast.author)
                        .font(.caption)
                        .foregroundColor(.spotifyLightGray)
                }
                Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical, 6)
        }
    }
}

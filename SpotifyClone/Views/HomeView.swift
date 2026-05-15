// HomeView.swift
// SpotifyClone

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var player: PlayerViewModel
    @State private var greeting = "Good evening"
    @State private var selectedFilter = 0

    private let recentSongs = Array(MockData.songs.prefix(6))
    private let madeForYouSongs = Array(MockData.songs.shuffled().prefix(6))
    private let newReleases = Array(MockData.albums.prefix(4))

    init() {
        let hour = Calendar.current.component(.hour, from: Date())
        if hour < 12 { _greeting = State(initialValue: "Good morning") }
        else if hour < 17 { _greeting = State(initialValue: "Good afternoon") }
    }

    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Color.spotifyBlack.ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {

                        // MARK: Header
                        HStack {
                            Text(greeting)
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.spotifyWhite)
                            Spacer()
                            HStack(spacing: 16) {
                                Button { } label: {
                                    Image(systemName: "bell")
                                        .font(.system(size: 20))
                                        .foregroundColor(.spotifyWhite)
                                }
                                Button { } label: {
                                    Image(systemName: "clock.arrow.circlepath")
                                        .font(.system(size: 20))
                                        .foregroundColor(.spotifyWhite)
                                }
                                // Profile avatar
                                Circle()
                                    .fill(LinearGradient(colors: [Color(hex: "6C63FF"), Color(hex: "3D2B8C")], startPoint: .topLeading, endPoint: .bottomTrailing))
                                    .frame(width: 32, height: 32)
                                    .overlay(
                                        Text("S")
                                            .font(.system(size: 14, weight: .bold))
                                            .foregroundColor(.white)
                                    )
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 12)
                        .padding(.bottom, 20)

                        // MARK: Quick Access Grid
                        quickAccessGrid

                        // MARK: Made For You
                        sectionHeader("Made For You")
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 14) {
                                ForEach(MockData.madeForYou) { playlist in
                                    PlaylistCard(playlist: playlist)
                                }
                                ForEach(recentSongs) { song in
                                    CardView(song: song)
                                }
                            }
                            .padding(.horizontal)
                        }
                        .padding(.bottom, 28)

                        // MARK: Recently Played
                        sectionHeader("Recently Played")
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 14) {
                                ForEach(recentSongs) { song in
                                    CardView(song: song)
                                }
                            }
                            .padding(.horizontal)
                        }
                        .padding(.bottom, 28)

                        // MARK: Featured Albums
                        sectionHeader("New Releases")
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 14) {
                                ForEach(newReleases) { album in
                                    AlbumCard(album: album)
                                }
                            }
                            .padding(.horizontal)
                        }
                        .padding(.bottom, 28)

                        // MARK: Featured Playlists
                        sectionHeader("Featured Playlists")
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 14) {
                                ForEach(MockData.featuredPlaylists) { playlist in
                                    PlaylistCard(playlist: playlist)
                                }
                            }
                            .padding(.horizontal)
                        }
                        .padding(.bottom, 28)

                        // MARK: Trending Artists
                        sectionHeader("Popular Artists")
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                ForEach(MockData.artists) { artist in
                                    NavigationLink(destination: ArtistView(artist: artist)) {
                                        VStack(spacing: 8) {
                                            Circle()
                                                .fill(LinearGradient(
                                                    colors: artist.gradientColors,
                                                    startPoint: .topLeading,
                                                    endPoint: .bottomTrailing
                                                ))
                                                .frame(width: 100, height: 100)
                                                .shadow(color: artist.gradientColors.first!.opacity(0.4), radius: 8)
                                                .overlay(
                                                    Text(String(artist.name.prefix(1)))
                                                        .font(.system(size: 36, weight: .bold))
                                                        .foregroundColor(.white)
                                                )

                                            Text(artist.name)
                                                .font(.caption.weight(.medium))
                                                .foregroundColor(.spotifyWhite)
                                                .lineLimit(1)
                                                .frame(width: 100)
                                        }
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding(.horizontal)
                        }
                        .padding(.bottom, 100)
                    }
                }
            }
            .navigationBarHidden(true)
            .fullScreenCover(isPresented: $player.showNowPlaying) {
                NowPlayingView()
                    .environmentObject(player)
            }
        }
    }

    // MARK: - Quick Access Grid (6 recenti in 2 colonne)
    private var quickAccessGrid: some View {
        let items = Array(MockData.playlists.prefix(6))
        return LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
            ForEach(items) { playlist in
                NavigationLink(destination: PlaylistDetailView(playlist: playlist)) {
                    HStack(spacing: 10) {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(LinearGradient(colors: playlist.gradientColors, startPoint: .topLeading, endPoint: .bottomTrailing))
                            .frame(width: 48, height: 48)
                            .overlay(
                                Group {
                                    if playlist.type == .liked {
                                        Image(systemName: "heart.fill").foregroundColor(.white).font(.system(size: 18))
                                    } else {
                                        Image(systemName: "music.note.list").foregroundColor(.white).font(.system(size: 16))
                                    }
                                }
                            )
                        Text(playlist.name)
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.spotifyWhite)
                            .lineLimit(2)
                        Spacer()
                    }
                    .background(Color.spotifyDarkGray.opacity(0.7))
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal)
        .padding(.bottom, 28)
    }

    private func sectionHeader(_ title: String) -> some View {
        Text(title)
            .font(.system(size: 22, weight: .bold))
            .foregroundColor(.spotifyWhite)
            .padding(.horizontal)
            .padding(.bottom, 14)
    }
}

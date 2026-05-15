// SpotifyCloneApp.swift
// SpotifyClone

import SwiftUI

@main
struct SpotifyCloneApp: App {
    @StateObject private var player = PlayerViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(player)
                .preferredColorScheme(.dark)
        }
    }
}

struct ContentView: View {
    @EnvironmentObject var player: PlayerViewModel
    @State private var selectedTab = 0

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tag(0)
                    .tabItem {
                        Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                        Text("Home")
                    }

                SearchView()
                    .tag(1)
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }

                LibraryView()
                    .tag(2)
                    .tabItem {
                        Image(systemName: selectedTab == 2 ? "books.vertical.fill" : "books.vertical")
                        Text("Library")
                    }

                RoomsListView()
                    .tag(3)
                    .tabItem {
                        Image(systemName: "waveform.and.person.filled")
                        Text("Vibe")
                    }
            }
            .accentColor(.spotifyGreen)

            // Mini Player floats above tab bar
            VStack(spacing: 0) {
                if player.currentSong != nil {
                    MiniPlayer()
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: player.currentSong != nil)
                }
                // spacer to push tab bar content below mini player
                Color.clear.frame(height: 0)
            }
            .padding(.bottom, 49) // tab bar height
        }
    }
}

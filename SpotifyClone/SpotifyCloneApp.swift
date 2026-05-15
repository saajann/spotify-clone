//
//  SpotifyCloneApp.swift
//  SpotifyClone
//
//  Created by Saajan Saini on 15/05/26.
//

import SwiftUI

@main
struct SpotifyCloneApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
        }
    }
}

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            LibraryView()
                .tabItem {
                    Image(systemName: "books.vertical.fill")
                    Text("Library")
                }
            RoomsListView()
                .tabItem {
                    Image(systemName: "person.2.fill")
                    Text("Rooms")
                }
        }
        .accentColor(.spotifyGreen)
    }
}

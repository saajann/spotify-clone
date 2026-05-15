//
//  RoomsListView.swift
//  SpotifyClone
//
//  Created by Saajan Saini on 15/05/26.
//

import SwiftUI

struct RoomsListView: View {
    var body: some View {
        NavigationStack {
            List(MockData.rooms) { room in
                NavigationLink(destination: RoomDetailView(room: room)) {
                    RoomRow(room: room)
                }
                .listRowBackground(Color.spotifyBlack)
            }
            .listStyle(.plain)
            .background(Color.spotifyBlack)
            .navigationTitle("Rooms")
            .navigationBarTitleDisplayMode(.large)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
    }
}

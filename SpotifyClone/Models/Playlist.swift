// Playlist.swift
// SpotifyClone

import SwiftUI

enum PlaylistType {
    case userCreated
    case madeForYou
    case editorial
    case liked
}

struct Playlist: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let owner: String
    let tracks: [Song]
    let gradientColors: [Color]
    let type: PlaylistType
    let followerCount: Int
}

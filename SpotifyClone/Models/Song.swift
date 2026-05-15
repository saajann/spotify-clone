// Song.swift
// SpotifyClone

import SwiftUI

struct Song: Identifiable {
    let id = UUID()
    let title: String
    let artist: String
    let album: String
    let duration: TimeInterval      // seconds
    let isExplicit: Bool
    let albumGradient: [Color]
    let dominantColor: Color
    var isLiked: Bool = false
}

extension Song {
    var formattedDuration: String {
        let minutes = Int(duration) / 60
        let seconds = Int(duration) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}

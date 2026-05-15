// Album.swift
// SpotifyClone

import SwiftUI

struct Album: Identifiable {
    let id = UUID()
    let title: String
    let artist: String
    let year: Int
    let trackCount: Int
    let tracks: [Song]
    let gradientColors: [Color]
    let dominantColor: Color
}

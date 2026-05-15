// Podcast.swift
// SpotifyClone

import SwiftUI

struct PodcastEpisode: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let duration: TimeInterval
    let publishedDate: String
    let isPlayed: Bool

    var formattedDuration: String {
        let hours = Int(duration) / 3600
        let minutes = (Int(duration) % 3600) / 60
        if hours > 0 { return "\(hours)h \(minutes)min" }
        return "\(minutes) min"
    }
}

struct Podcast: Identifiable {
    let id = UUID()
    let title: String
    let author: String
    let description: String
    let episodes: [PodcastEpisode]
    let gradientColors: [Color]
}

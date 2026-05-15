// Artist.swift
// SpotifyClone

import SwiftUI

struct Artist: Identifiable {
    let id = UUID()
    let name: String
    let bio: String
    let followers: Int
    let monthlyListeners: Int
    let topTracks: [Song]
    let gradientColors: [Color]
    let verified: Bool
}

extension Artist {
    var formattedFollowers: String {
        if followers >= 1_000_000 {
            return String(format: "%.1fM", Double(followers) / 1_000_000)
        } else if followers >= 1_000 {
            return String(format: "%.1fK", Double(followers) / 1_000)
        }
        return "\(followers)"
    }

    var formattedMonthlyListeners: String {
        if monthlyListeners >= 1_000_000 {
            return String(format: "%.1fM monthly listeners", Double(monthlyListeners) / 1_000_000)
        }
        return "\(monthlyListeners) monthly listeners"
    }
}

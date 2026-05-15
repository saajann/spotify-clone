// Room.swift
// SpotifyClone

import SwiftUI

// MARK: - Vibe Mood
enum VibeMood: String, CaseIterable {
    case chill      = "Chill"
    case hype       = "Hype"
    case focus      = "Focus"
    case lofi       = "Lo-Fi"
    case party      = "Party"
    case romantic   = "Romantic"
    case sad        = "Melancholic"

    var emoji: String {
        switch self {
        case .chill:    return "🌊"
        case .hype:     return "🔥"
        case .focus:    return "🧠"
        case .lofi:     return "🌙"
        case .party:    return "🎉"
        case .romantic: return "💫"
        case .sad:      return "🫧"
        }
    }

    var gradient: [Color] {
        switch self {
        case .chill:    return [Color(hex: "0D7DB8"), Color(hex: "0B3D5E")]
        case .hype:     return [Color(hex: "E84545"), Color(hex: "903749")]
        case .focus:    return [Color(hex: "6C63FF"), Color(hex: "3D2B8C")]
        case .lofi:     return [Color(hex: "B8860B"), Color(hex: "4A3728")]
        case .party:    return [Color(hex: "FF6B6B"), Color(hex: "C026D3")]
        case .romantic: return [Color(hex: "FF85A1"), Color(hex: "7B2D8B")]
        case .sad:      return [Color(hex: "4A90A4"), Color(hex: "1A3045")]
        }
    }

    var accentColor: Color {
        switch self {
        case .chill:    return Color(hex: "4FC3F7")
        case .hype:     return Color(hex: "FF6B6B")
        case .focus:    return Color(hex: "A78BFA")
        case .lofi:     return Color(hex: "F6C90E")
        case .party:    return Color(hex: "FF6BCB")
        case .romantic: return Color(hex: "FFB3C6")
        case .sad:      return Color(hex: "90CAF9")
        }
    }
}

// MARK: - Room User
struct RoomUser: Identifiable {
    let id = UUID()
    let name: String
    let avatar: String   // SF Symbol
    let isDJ: Bool
    var moodVote: String? // emoji vote
    // Spatial position angle (0-360) around the circle
    var angle: Double
}

// MARK: - DJ Queue Item
struct QueueItem: Identifiable {
    let id = UUID()
    let song: Song
    let proposedBy: String
    var votes: Int
    var hasVoted: Bool = false
}

// MARK: - Room
struct Room: Identifiable {
    let id = UUID()
    let name: String
    var currentMood: VibeMood
    var currentSong: Song
    var users: [RoomUser]
    var djQueue: [QueueItem]
    let isLive: Bool
    let listenerCount: Int
}

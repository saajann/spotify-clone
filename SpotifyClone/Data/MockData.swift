//
//  MockData.swift
//  SpotifyClone
//
//  Created by Saajan Saini on 15/05/26.
//

import Foundation

struct MockData {
    static let songs: [Song] = [
        Song(title: "Blinding Lights", artist: "The Weeknd", albumArt: "sparkles"),
        Song(title: "As It Was", artist: "Harry Styles", albumArt: "star"),
        Song(title: "Flowers", artist: "Miley Cyrus", albumArt: "camera.macro"),
        Song(title: "Anti-Hero", artist: "Taylor Swift", albumArt: "music.mic"),
        Song(title: "Shape of You", artist: "Ed Sheeran", albumArt: "guitars"),
        Song(title: "Stay", artist: "The Kid LAROI", albumArt: "waveform"),
        Song(title: "Heat Waves", artist: "Glass Animals", albumArt: "flame"),
        Song(title: "Good 4 U", artist: "Olivia Rodrigo", albumArt: "bolt"),
        Song(title: "Levitating", artist: "Dua Lipa", albumArt: "moon.stars"),
        Song(title: "Save Your Tears", artist: "The Weeknd", albumArt: "drop")
    ]

    static let rooms: [Room] = [
        Room(name: "Chill Vibes", mood: "chill", currentSong: songs[0], users: ["Alice", "Bob", "Charlie"]),
        Room(name: "Friday Party", mood: "party", currentSong: songs[3], users: ["Dave", "Eve", "Frank", "Grace"]),
        Room(name: "Deep Focus", mood: "focus", currentSong: songs[7], users: ["Heidi", "Ivan"]),
        Room(name: "Late Night", mood: "chill", currentSong: songs[2], users: ["Judy", "Mallory", "Nick"]),
        Room(name: "Workout Beats", mood: "party", currentSong: songs[5], users: ["Oscar", "Peggy", "Quinn", "Rita"])
    ]
}

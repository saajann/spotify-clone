// PlayerViewModel.swift
// SpotifyClone

import SwiftUI
import Combine

@MainActor
class PlayerViewModel: ObservableObject {
    @Published var currentSong: Song? = MockData.songs.first
    @Published var isPlaying: Bool = false
    @Published var isShuffled: Bool = false
    @Published var repeatMode: RepeatMode = .off
    @Published var progress: Double = 0.32       // 0.0–1.0
    @Published var volume: Double = 0.7
    @Published var showNowPlaying: Bool = false
    @Published var queue: [Song] = Array(MockData.songs.dropFirst())

    enum RepeatMode {
        case off, one, all
        mutating func cycle() {
            switch self {
            case .off: self = .one
            case .one: self = .all
            case .all: self = .off
            }
        }
        var icon: String {
            switch self {
            case .off:  return "repeat"
            case .one:  return "repeat.1"
            case .all:  return "repeat"
            }
        }
        var isActive: Bool { self != .off }
    }

    var currentDuration: TimeInterval { currentSong?.duration ?? 0 }
    var currentTime: TimeInterval { currentDuration * progress }

    func play(_ song: Song) {
        currentSong = song
        isPlaying = true
        progress = 0
    }

    func togglePlayPause() {
        isPlaying.toggle()
    }

    func next() {
        guard let current = currentSong,
              let idx = queue.firstIndex(where: { $0.id == current.id }) else {
            if !queue.isEmpty { currentSong = queue[0]; isPlaying = true }
            return
        }
        let next = queue.index(after: idx)
        if next < queue.endIndex {
            currentSong = queue[next]
        } else if repeatMode == .all {
            currentSong = queue[0]
        }
        isPlaying = true
        progress = 0
    }

    func previous() {
        if progress > 0.05 {
            progress = 0
            return
        }
        guard let current = currentSong,
              let idx = queue.firstIndex(where: { $0.id == current.id }),
              idx > 0 else { return }
        currentSong = queue[idx - 1]
        progress = 0
        isPlaying = true
    }

    func seek(to value: Double) {
        progress = max(0, min(1, value))
    }
}

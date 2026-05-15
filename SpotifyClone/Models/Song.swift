//
//  Song.swift
//  SpotifyClone
//
//  Created by Saajan Saini on 15/05/26.
//

import Foundation

struct Song: Identifiable {
    let id = UUID()
    let title: String
    let artist: String
    let albumArt: String // SF Symbol name as placeholder
}

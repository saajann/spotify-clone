//
//  Room..swift
//  SpotifyClone
//
//  Created by Saajan Saini on 15/05/26.
//

import Foundation

struct Room: Identifiable {
    let id = UUID()
    let name: String
    let mood: String
    let currentSong: Song
    let users: [String]
}

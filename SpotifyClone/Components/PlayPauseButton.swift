//
//  PlayPauseButton.swift
//  SpotifyClone
//
//  Created by Saajan Saini on 15/05/26.
//

import SwiftUI

struct PlayPauseButton: View {
    @Binding var isPlaying: Bool

    var body: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.2)) {
                isPlaying.toggle()
            }
        } label: {
            Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                .font(.system(size: 64))
                .foregroundColor(.spotifyGreen)
                .background(Circle().fill(Color.black).shadow(radius: 8))
        }
    }
}

// PlayPauseButton.swift
// SpotifyClone

import SwiftUI

struct PlayPauseButton: View {
    @Binding var isPlaying: Bool
    var size: CGFloat = 60
    var color: Color = .spotifyGreen

    var body: some View {
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                isPlaying.toggle()
            }
        } label: {
            ZStack {
                Circle()
                    .fill(color)
                    .frame(width: size, height: size)
                    .shadow(color: color.opacity(0.5), radius: 12, x: 0, y: 4)

                Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                    .font(.system(size: size * 0.38, weight: .bold))
                    .foregroundColor(.black)
                    .offset(x: isPlaying ? 0 : 2)
            }
        }
        .scaleEffect(isPlaying ? 1.0 : 0.96)
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPlaying)
    }
}

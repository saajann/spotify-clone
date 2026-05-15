// FloatingEmojiView.swift
// SpotifyClone

import SwiftUI

struct FloatingEmojiOverlay: View {
    let floaters: [RoomViewModel.FloatingEmoji]

    var body: some View {
        ZStack {
            ForEach(floaters) { floater in
                FloatingEmojiParticle(floater: floater)
            }
        }
        .allowsHitTesting(false)
    }
}

private struct FloatingEmojiParticle: View {
    let floater: RoomViewModel.FloatingEmoji
    @State private var yOffset: CGFloat = 0
    @State private var opacity: Double = 1
    @State private var scale: CGFloat = 0.4

    var body: some View {
        Text(floater.emoji)
            .font(.system(size: 36))
            .offset(x: floater.xOffset, y: yOffset)
            .opacity(opacity)
            .scaleEffect(scale)
            .onAppear {
                withAnimation(.easeOut(duration: 2.0)) {
                    yOffset = -220
                    opacity = 0
                    scale = 1.2
                }
            }
    }
}

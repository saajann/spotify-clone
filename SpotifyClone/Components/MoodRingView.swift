// MoodRingView.swift
// SpotifyClone

import SwiftUI

struct MoodRingView: View {
    let mood: VibeMood
    @State private var rotate: Double = 0
    @State private var pulse: Bool = false

    var body: some View {
        ZStack {
            // Outer glow ring
            Circle()
                .stroke(
                    AngularGradient(
                        colors: mood.gradient + [mood.gradient.first!],
                        center: .center,
                        startAngle: .degrees(rotate),
                        endAngle: .degrees(rotate + 360)
                    ),
                    lineWidth: 4
                )
                .blur(radius: 6)
                .scaleEffect(pulse ? 1.08 : 1.0)
                .animation(.easeInOut(duration: 1.6).repeatForever(autoreverses: true), value: pulse)

            // Inner ring
            Circle()
                .stroke(
                    AngularGradient(
                        colors: mood.gradient + [mood.gradient.first!],
                        center: .center,
                        startAngle: .degrees(rotate),
                        endAngle: .degrees(rotate + 360)
                    ),
                    lineWidth: 2
                )

            // Center emoji
            Text(mood.emoji)
                .font(.system(size: 28))
                .scaleEffect(pulse ? 1.1 : 1.0)
                .animation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true), value: pulse)
        }
        .onAppear {
            pulse = true
            withAnimation(.linear(duration: 6).repeatForever(autoreverses: false)) {
                rotate = 360
            }
        }
    }
}

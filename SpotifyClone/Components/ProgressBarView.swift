// ProgressBarView.swift
// SpotifyClone

import SwiftUI

struct ProgressBarView: View {
    @Binding var progress: Double
    let duration: TimeInterval
    var accentColor: Color = .spotifyWhite
    @State private var isDragging = false

    var currentTime: TimeInterval { duration * progress }

    var body: some View {
        VStack(spacing: 8) {
            // Track
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .frame(height: isDragging ? 5 : 4)

                    Capsule()
                        .fill(accentColor)
                        .frame(width: geo.size.width * progress, height: isDragging ? 5 : 4)

                    // Thumb
                    Circle()
                        .fill(Color.white)
                        .frame(width: isDragging ? 16 : 0, height: isDragging ? 16 : 0)
                        .offset(x: geo.size.width * progress - (isDragging ? 8 : 0))
                        .animation(.easeInOut(duration: 0.15), value: isDragging)
                }
                .frame(height: 16)
                .contentShape(Rectangle())
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            isDragging = true
                            let new = value.location.x / geo.size.width
                            progress = max(0, min(1, new))
                        }
                        .onEnded { _ in
                            isDragging = false
                        }
                )
            }
            .frame(height: 16)

            // Time labels
            HStack {
                Text(formatTime(currentTime))
                Spacer()
                Text("-\(formatTime(duration - currentTime))")
            }
            .font(.system(size: 11))
            .foregroundColor(.white.opacity(0.6))
        }
    }

    private func formatTime(_ t: TimeInterval) -> String {
        let m = Int(t) / 60
        let s = Int(t) % 60
        return String(format: "%d:%02d", m, s)
    }
}

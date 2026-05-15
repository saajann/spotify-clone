// UserAvatarCircleView.swift
// SpotifyClone

import SwiftUI

struct UserAvatarCircleView: View {
    let users: [RoomUser]
    let radius: CGFloat
    let mood: VibeMood

    var body: some View {
        ZStack {
            // Connection lines
            ForEach(users) { user in
                let pos = position(for: user.angle)
                Path { path in
                    path.move(to: CGPoint(x: radius, y: radius))
                    path.addLine(to: pos)
                }
                .stroke(mood.accentColor.opacity(0.2), lineWidth: 1)
            }

            // User avatars
            ForEach(users) { user in
                let pos = position(for: user.angle)
                AvatarBubble(user: user, mood: mood)
                    .position(pos)
            }
        }
        .frame(width: radius * 2, height: radius * 2)
    }

    private func position(for angle: Double) -> CGPoint {
        let rad = angle * .pi / 180
        return CGPoint(
            x: radius + (radius - 30) * cos(rad),
            y: radius + (radius - 30) * sin(rad)
        )
    }
}

private struct AvatarBubble: View {
    let user: RoomUser
    let mood: VibeMood
    @State private var pulse = false

    var body: some View {
        VStack(spacing: 4) {
            ZStack {
                // Outer glow for DJ
                if user.isDJ {
                    Circle()
                        .stroke(mood.accentColor, lineWidth: 2)
                        .frame(width: 48, height: 48)
                        .scaleEffect(pulse ? 1.2 : 1.0)
                        .opacity(pulse ? 0 : 0.8)
                        .animation(.easeOut(duration: 1.2).repeatForever(), value: pulse)
                }

                Circle()
                    .fill(LinearGradient(
                        colors: user.isDJ ? mood.gradient : [Color.spotifyMidGray, Color.spotifyDarkGray],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                    .frame(width: 40, height: 40)

                Text(String(user.name.prefix(1)).uppercased())
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(.white)

                // DJ crown
                if user.isDJ {
                    Image(systemName: "crown.fill")
                        .font(.system(size: 10))
                        .foregroundColor(.yellow)
                        .offset(y: -24)
                }
            }

            // Mood vote bubble
            if let vote = user.moodVote {
                Text(vote)
                    .font(.system(size: 12))
                    .padding(4)
                    .background(.ultraThinMaterial)
                    .clipShape(Capsule())
            }
        }
        .onAppear { if user.isDJ { pulse = true } }
    }
}

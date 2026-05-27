// RoomRow.swift
// SpotifyClone

import SwiftUI

struct RoomRow: View {
    let room: Room
    var isJoined: Bool = false
    @State private var pulse = false

    var body: some View {
        ZStack(alignment: .topTrailing) {
            // Background gradient
            RoundedRectangle(cornerRadius: 14)
                .fill(LinearGradient(
                    colors: room.currentMood.gradient.map { $0.opacity(0.45) } + [Color.spotifyDarkGray.opacity(0.8)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(room.currentMood.accentColor.opacity(isJoined ? 0.6 : 0.25), lineWidth: isJoined ? 1.5 : 1)
                )

            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    // Live badge
                    if room.isLive {
                        HStack(spacing: 5) {
                            Circle()
                                .fill(Color.red)
                                .frame(width: 6, height: 6)
                                .scaleEffect(pulse ? 1.3 : 0.8)
                                .animation(.easeInOut(duration: 0.7).repeatForever(autoreverses: true), value: pulse)
                            Text("LIVE")
                                .font(.system(size: 10, weight: .black))
                                .foregroundColor(.red)
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.red.opacity(0.15))
                        .clipShape(Capsule())
                    }

                    if isJoined {
                        HStack(spacing: 4) {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 10))
                            Text("JOINED")
                                .font(.system(size: 10, weight: .black))
                        }
                        .foregroundColor(.spotifyGreen)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.spotifyGreen.opacity(0.15))
                        .clipShape(Capsule())
                    }

                    Spacer()

                    // Mood emoji badge
                    Text(room.currentMood.emoji)
                        .font(.title3)
                }

                // Room name
                Text(room.name)
                    .font(.headline.weight(.bold))
                    .foregroundColor(.white)

                // Currently playing
                HStack(spacing: 6) {
                    Image(systemName: "music.note")
                        .font(.caption)
                        .foregroundColor(room.currentMood.accentColor)
                    Text("\(room.currentSong.title) · \(room.currentSong.artist)")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.75))
                        .lineLimit(1)
                }

                // Stacked user avatars + footer
                HStack {
                    // Stacked avatars
                    stackedAvatars

                    Spacer()

                    // Listener count
                    HStack(spacing: 4) {
                        Image(systemName: "person.2.fill")
                            .font(.caption2)
                        Text("\(room.listenerCount)")
                            .font(.caption2)
                    }
                    .foregroundColor(.white.opacity(0.6))

                    // Mood tag
                    Text(room.currentMood.rawValue)
                        .font(.caption2.weight(.semibold))
                        .foregroundColor(room.currentMood.accentColor)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(room.currentMood.accentColor.opacity(0.15))
                        .clipShape(Capsule())
                }
            }
            .padding(14)
        }
        .frame(maxWidth: .infinity)
        .onAppear { pulse = true }
    }

    private var stackedAvatars: some View {
        let displayUsers = Array(room.users.prefix(5))
        let overflow = room.users.count - displayUsers.count

        return HStack(spacing: -8) {
            ForEach(Array(displayUsers.enumerated()), id: \.element.id) { index, user in
                ZStack {
                    Circle()
                        .fill(LinearGradient(
                            colors: avatarGradient(for: user.profileImageURL),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        .frame(width: 28, height: 28)

                    Text(String(user.name.prefix(1)).uppercased())
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(.white)
                }
                .overlay(
                    Circle()
                        .stroke(Color.spotifyDarkGray, lineWidth: 2)
                )
                .zIndex(Double(displayUsers.count - index))
            }

            if overflow > 0 {
                ZStack {
                    Circle()
                        .fill(Color.spotifyMidGray)
                        .frame(width: 28, height: 28)

                    Text("+\(overflow)")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(.white)
                }
                .overlay(
                    Circle()
                        .stroke(Color.spotifyDarkGray, lineWidth: 2)
                )
            }
        }
    }

    private func avatarGradient(for hex: String) -> [Color] {
        let base = Color(hex: hex)
        return [base, base.opacity(0.6)]
    }
}

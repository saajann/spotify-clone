// CreateRoomView.swift
// SpotifyClone

import SwiftUI

struct CreateRoomView: View {
    @Environment(\.dismiss) var dismiss
    @State private var roomName = ""
    @State private var selectedMood: VibeMood = .chill
    @State private var roomDescription = ""
    @State private var isCreating = false
    @State private var showSuccess = false

    var onCreateRoom: (Room) -> Void

    var body: some View {
        NavigationStack {
            ZStack {
                // Background
                LinearGradient(
                    colors: selectedMood.gradient + [Color.spotifyBlack],
                    startPoint: .top,
                    endPoint: .center
                )
                .ignoresSafeArea()
                .animation(.easeInOut(duration: 0.6), value: selectedMood)

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 28) {

                        // Mood preview ring
                        ZStack {
                            MoodRingView(mood: selectedMood)
                                .frame(width: 100, height: 100)

                            Text(selectedMood.emoji)
                                .font(.system(size: 36))
                        }
                        .padding(.top, 20)

                        // Room name
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Room Name")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(.white.opacity(0.6))

                            TextField("Give your room a name...", text: $roomName)
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(16)
                                .background(Color.white.opacity(0.08))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(selectedMood.accentColor.opacity(0.3), lineWidth: 1)
                                )
                        }
                        .padding(.horizontal, 20)

                        // Mood selector
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Set the Mood")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(.white.opacity(0.6))
                                .padding(.horizontal, 20)

                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {
                                    ForEach(VibeMood.allCases, id: \.rawValue) { mood in
                                        Button {
                                            withAnimation(.spring(response: 0.3)) {
                                                selectedMood = mood
                                            }
                                        } label: {
                                            VStack(spacing: 8) {
                                                ZStack {
                                                    Circle()
                                                        .fill(LinearGradient(
                                                            colors: mood.gradient,
                                                            startPoint: .topLeading,
                                                            endPoint: .bottomTrailing
                                                        ))
                                                        .frame(width: 56, height: 56)

                                                    if selectedMood == mood {
                                                        Circle()
                                                            .stroke(Color.white, lineWidth: 2.5)
                                                            .frame(width: 56, height: 56)
                                                    }

                                                    Text(mood.emoji)
                                                        .font(.system(size: 24))
                                                }

                                                Text(mood.rawValue)
                                                    .font(.system(size: 11, weight: selectedMood == mood ? .bold : .regular))
                                                    .foregroundColor(selectedMood == mood ? .white : .white.opacity(0.5))
                                            }
                                        }
                                    }
                                }
                                .padding(.horizontal, 20)
                            }
                        }

                        // Description
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Description (optional)")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(.white.opacity(0.6))

                            TextField("What's this room about?", text: $roomDescription, axis: .vertical)
                                .font(.system(size: 15))
                                .foregroundColor(.white)
                                .lineLimit(3...5)
                                .padding(16)
                                .background(Color.white.opacity(0.08))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(selectedMood.accentColor.opacity(0.3), lineWidth: 1)
                                )
                        }
                        .padding(.horizontal, 20)

                        // Room preview card
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Text("Preview")
                                    .font(.system(size: 13, weight: .semibold))
                                    .foregroundColor(.white.opacity(0.5))
                                Spacer()
                            }

                            HStack(spacing: 14) {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(LinearGradient(
                                        colors: selectedMood.gradient,
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ))
                                    .frame(width: 50, height: 50)
                                    .overlay(
                                        Text(selectedMood.emoji)
                                            .font(.system(size: 22))
                                    )

                                VStack(alignment: .leading, spacing: 4) {
                                    Text(roomName.isEmpty ? "Your Room Name" : roomName)
                                        .font(.system(size: 16, weight: .bold))
                                        .foregroundColor(.white)
                                    Text("\(selectedMood.rawValue) · 1 listening")
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.6))
                                }

                                Spacer()
                            }
                            .padding(14)
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                        }
                        .padding(.horizontal, 20)

                        Spacer(minLength: 40)
                    }
                }

                // Success overlay
                if showSuccess {
                    ZStack {
                        Color.black.opacity(0.8).ignoresSafeArea()

                        VStack(spacing: 20) {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 64))
                                .foregroundColor(.spotifyGreen)
                                .transition(.scale.combined(with: .opacity))

                            Text("Room Created!")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)

                            Text("Your vibe room is now live")
                                .font(.system(size: 15))
                                .foregroundColor(.white.opacity(0.7))
                        }
                    }
                    .transition(.opacity)
                }
            }
            .navigationTitle("Create Room")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                        .foregroundColor(.white)
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        createRoom()
                    } label: {
                        Text("Create")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(roomName.isEmpty ? .white.opacity(0.3) : .spotifyBlack)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(roomName.isEmpty ? Color.white.opacity(0.1) : Color.spotifyGreen)
                            .clipShape(Capsule())
                    }
                    .disabled(roomName.isEmpty || isCreating)
                }
            }
        }
    }

    private func createRoom() {
        isCreating = true
        withAnimation(.spring()) {
            showSuccess = true
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            let newRoom = Room(
                name: roomName,
                currentMood: selectedMood,
                currentSong: MockData.songs.randomElement()!,
                users: [
                    RoomUser(name: "You", avatar: "person.fill", profileImageURL: "1DB954", isDJ: true, moodVote: selectedMood.emoji, angle: 0),
                ],
                djQueue: [],
                isLive: true,
                listenerCount: 1,
                chatMessages: [
                    ChatMessage(userName: "You", text: "Welcome to \(roomName)! 🎉", timestamp: "now", isMe: true),
                ],
                songVoteOptions: []
            )
            onCreateRoom(newRoom)
            dismiss()
        }
    }
}

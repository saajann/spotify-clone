// MockData.swift
// SpotifyClone

import SwiftUI

struct MockData {

    // MARK: - Songs
    static let songs: [Song] = [
        Song(title: "Blinding Lights", artist: "The Weeknd", album: "After Hours",
             duration: 200, isExplicit: false,
             albumGradient: [Color(hex: "8B0000"), Color(hex: "1A0000")],
             dominantColor: Color(hex: "8B0000"), isLiked: true),

        Song(title: "As It Was", artist: "Harry Styles", album: "Harry's House",
             duration: 167, isExplicit: false,
             albumGradient: [Color(hex: "FF6B9D"), Color(hex: "7B2869")],
             dominantColor: Color(hex: "FF6B9D"), isLiked: false),

        Song(title: "Flowers", artist: "Miley Cyrus", album: "Endless Summer Vacation",
             duration: 200, isExplicit: false,
             albumGradient: [Color(hex: "F4A460"), Color(hex: "8B4513")],
             dominantColor: Color(hex: "F4A460"), isLiked: true),

        Song(title: "Anti-Hero", artist: "Taylor Swift", album: "Midnights",
             duration: 200, isExplicit: false,
             albumGradient: [Color(hex: "0D0D1A"), Color(hex: "2D1B4E")],
             dominantColor: Color(hex: "2D1B4E"), isLiked: true),

        Song(title: "Shape of You", artist: "Ed Sheeran", album: "÷",
             duration: 234, isExplicit: false,
             albumGradient: [Color(hex: "FF6B00"), Color(hex: "8B3500")],
             dominantColor: Color(hex: "FF6B00"), isLiked: false),

        Song(title: "Stay", artist: "The Kid LAROI, Justin Bieber", album: "F*CK LOVE 3",
             duration: 141, isExplicit: true,
             albumGradient: [Color(hex: "1A1A2E"), Color(hex: "16213E")],
             dominantColor: Color(hex: "1A1A2E"), isLiked: false),

        Song(title: "Heat Waves", artist: "Glass Animals", album: "Dreamland",
             duration: 238, isExplicit: false,
             albumGradient: [Color(hex: "FF8C00"), Color(hex: "DC143C")],
             dominantColor: Color(hex: "FF8C00"), isLiked: true),

        Song(title: "good 4 u", artist: "Olivia Rodrigo", album: "SOUR",
             duration: 178, isExplicit: false,
             albumGradient: [Color(hex: "6A0DAD"), Color(hex: "2D0066")],
             dominantColor: Color(hex: "6A0DAD"), isLiked: false),

        Song(title: "Levitating", artist: "Dua Lipa", album: "Future Nostalgia",
             duration: 203, isExplicit: false,
             albumGradient: [Color(hex: "9B59B6"), Color(hex: "3498DB")],
             dominantColor: Color(hex: "9B59B6"), isLiked: true),

        Song(title: "Save Your Tears", artist: "The Weeknd", album: "After Hours",
             duration: 215, isExplicit: false,
             albumGradient: [Color(hex: "C0392B"), Color(hex: "1A0000")],
             dominantColor: Color(hex: "C0392B"), isLiked: false),

        Song(title: "Industry Baby", artist: "Lil Nas X, Jack Harlow", album: "MONTERO",
             duration: 212, isExplicit: true,
             albumGradient: [Color(hex: "FF4500"), Color(hex: "8B2500")],
             dominantColor: Color(hex: "FF4500"), isLiked: false),

        Song(title: "Peaches", artist: "Justin Bieber", album: "Justice",
             duration: 198, isExplicit: true,
             albumGradient: [Color(hex: "FFAB00"), Color(hex: "7B4F00")],
             dominantColor: Color(hex: "FFAB00"), isLiked: true),

        Song(title: "Watermelon Sugar", artist: "Harry Styles", album: "Fine Line",
             duration: 174, isExplicit: false,
             albumGradient: [Color(hex: "FF6B6B"), Color(hex: "8B0000")],
             dominantColor: Color(hex: "FF6B6B"), isLiked: false),

        Song(title: "Butter", artist: "BTS", album: "Butter",
             duration: 164, isExplicit: false,
             albumGradient: [Color(hex: "FFD700"), Color(hex: "8B6914")],
             dominantColor: Color(hex: "FFD700"), isLiked: true),

        Song(title: "drivers license", artist: "Olivia Rodrigo", album: "SOUR",
             duration: 242, isExplicit: false,
             albumGradient: [Color(hex: "C471ED"), Color(hex: "12C2E9")],
             dominantColor: Color(hex: "C471ED"), isLiked: true),

        Song(title: "Bad Habits", artist: "Ed Sheeran", album: "=",
             duration: 231, isExplicit: false,
             albumGradient: [Color(hex: "1A1A1A"), Color(hex: "FF0080")],
             dominantColor: Color(hex: "FF0080"), isLiked: false),

        Song(title: "Kiss Me More", artist: "Doja Cat, SZA", album: "Planet Her",
             duration: 208, isExplicit: true,
             albumGradient: [Color(hex: "FF69B4"), Color(hex: "8B1A4A")],
             dominantColor: Color(hex: "FF69B4"), isLiked: true),

        Song(title: "Montero", artist: "Lil Nas X", album: "MONTERO",
             duration: 137, isExplicit: true,
             albumGradient: [Color(hex: "7C3AED"), Color(hex: "1E0050")],
             dominantColor: Color(hex: "7C3AED"), isLiked: false),

        Song(title: "Leave The Door Open", artist: "Silk Sonic", album: "An Evening with Silk Sonic",
             duration: 243, isExplicit: false,
             albumGradient: [Color(hex: "D4A017"), Color(hex: "5C3800")],
             dominantColor: Color(hex: "D4A017"), isLiked: true),

        Song(title: "Shivers", artist: "Ed Sheeran", album: "=",
             duration: 207, isExplicit: false,
             albumGradient: [Color(hex: "00C9FF"), Color(hex: "006B92")],
             dominantColor: Color(hex: "00C9FF"), isLiked: false),
    ]

    // MARK: - Albums
    static let albums: [Album] = [
        Album(title: "After Hours", artist: "The Weeknd", year: 2020, trackCount: 14,
              tracks: Array(songs.filter { $0.album == "After Hours" }),
              gradientColors: [Color(hex: "8B0000"), Color(hex: "1A0000")],
              dominantColor: Color(hex: "8B0000")),

        Album(title: "Harry's House", artist: "Harry Styles", year: 2022, trackCount: 13,
              tracks: Array(songs.filter { $0.album == "Harry's House" }),
              gradientColors: [Color(hex: "FF6B9D"), Color(hex: "7B2869")],
              dominantColor: Color(hex: "FF6B9D")),

        Album(title: "Midnights", artist: "Taylor Swift", year: 2022, trackCount: 13,
              tracks: Array(songs.filter { $0.album == "Midnights" }),
              gradientColors: [Color(hex: "0D0D1A"), Color(hex: "2D1B4E")],
              dominantColor: Color(hex: "2D1B4E")),

        Album(title: "SOUR", artist: "Olivia Rodrigo", year: 2021, trackCount: 11,
              tracks: Array(songs.filter { $0.album == "SOUR" }),
              gradientColors: [Color(hex: "6A0DAD"), Color(hex: "2D0066")],
              dominantColor: Color(hex: "6A0DAD")),

        Album(title: "Future Nostalgia", artist: "Dua Lipa", year: 2020, trackCount: 11,
              tracks: Array(songs.filter { $0.album == "Future Nostalgia" }),
              gradientColors: [Color(hex: "9B59B6"), Color(hex: "3498DB")],
              dominantColor: Color(hex: "9B59B6")),

        Album(title: "MONTERO", artist: "Lil Nas X", year: 2021, trackCount: 15,
              tracks: Array(songs.filter { $0.album == "MONTERO" }),
              gradientColors: [Color(hex: "7C3AED"), Color(hex: "1E0050")],
              dominantColor: Color(hex: "7C3AED")),
    ]

    // MARK: - Artists
    static let artists: [Artist] = [
        Artist(name: "The Weeknd", bio: "Abel Makkonen Tesfaye, known professionally as The Weeknd, is a Canadian singer and songwriter known for his genre-blending style.",
               followers: 45_200_000, monthlyListeners: 91_400_000,
               topTracks: Array(songs.filter { $0.artist == "The Weeknd" }),
               gradientColors: [Color(hex: "8B0000"), Color(hex: "1A0000")],
               verified: true),

        Artist(name: "Taylor Swift", bio: "Taylor Alison Swift is an American singer-songwriter whose artistry and influence have made her a defining figure of 21st century pop music.",
               followers: 72_000_000, monthlyListeners: 82_600_000,
               topTracks: Array(songs.filter { $0.artist == "Taylor Swift" }),
               gradientColors: [Color(hex: "0D0D1A"), Color(hex: "9B59B6")],
               verified: true),

        Artist(name: "Harry Styles", bio: "Harry Edward Styles is an English singer, songwriter, and actor known for his distinctive voice and eclectic fashion sense.",
               followers: 38_900_000, monthlyListeners: 64_200_000,
               topTracks: Array(songs.filter { $0.artist == "Harry Styles" }),
               gradientColors: [Color(hex: "FF6B9D"), Color(hex: "7B2869")],
               verified: true),

        Artist(name: "Olivia Rodrigo", bio: "Olivia Isabel Rodrigo is an American singer, songwriter and actress. Her debut single drivers license broke multiple streaming records.",
               followers: 29_500_000, monthlyListeners: 49_800_000,
               topTracks: Array(songs.filter { $0.artist == "Olivia Rodrigo" }),
               gradientColors: [Color(hex: "6A0DAD"), Color(hex: "C471ED")],
               verified: true),

        Artist(name: "Dua Lipa", bio: "Dua Lipa is a British-Albanian singer and songwriter. Her second studio album Future Nostalgia won the Grammy for Best Pop Vocal Album.",
               followers: 54_000_000, monthlyListeners: 71_300_000,
               topTracks: Array(songs.filter { $0.artist.contains("Dua Lipa") }),
               gradientColors: [Color(hex: "9B59B6"), Color(hex: "3498DB")],
               verified: true),

        Artist(name: "Ed Sheeran", bio: "Edward Christopher Sheeran is an English singer, songwriter, and record producer. He is one of the best-selling music artists of all time.",
               followers: 82_000_000, monthlyListeners: 78_500_000,
               topTracks: Array(songs.filter { $0.artist.contains("Ed Sheeran") }),
               gradientColors: [Color(hex: "FF6B00"), Color(hex: "8B3500")],
               verified: true),
    ]

    // MARK: - Playlists
    static let playlists: [Playlist] = [
        Playlist(name: "Liked Songs", description: "Your saved songs",
                 owner: "You", tracks: Array(songs.filter { $0.isLiked }),
                 gradientColors: [Color(hex: "4B00E0"), Color(hex: "0D72EA")],
                 type: .liked, followerCount: 0),

        Playlist(name: "Daily Mix 1", description: "The Weeknd, Harry Styles and more",
                 owner: "Spotify", tracks: Array(songs.prefix(8)),
                 gradientColors: [Color(hex: "E13300"), Color(hex: "3D0000")],
                 type: .madeForYou, followerCount: 0),

        Playlist(name: "Discover Weekly", description: "Your weekly mixtape of fresh music. Enjoy new music and deep cuts picked for you.",
                 owner: "Spotify", tracks: Array(songs.shuffled().prefix(10)),
                 gradientColors: [Color(hex: "503750"), Color(hex: "121212")],
                 type: .madeForYou, followerCount: 0),

        Playlist(name: "Hot Hits Global", description: "The most played tracks right now.",
                 owner: "Spotify", tracks: Array(songs),
                 gradientColors: [Color(hex: "D91F11"), Color(hex: "1A0000")],
                 type: .editorial, followerCount: 12_400_000),

        Playlist(name: "Chill Vibes", description: "Perfect soundtrack for unwinding.",
                 owner: "You", tracks: Array(songs.filter { $0.dominantColor == Color(hex: "4FC3F7") || !$0.isExplicit }.prefix(8)),
                 gradientColors: [Color(hex: "0D7DB8"), Color(hex: "0B3D5E")],
                 type: .userCreated, followerCount: 0),

        Playlist(name: "Late Night Drive", description: "Dark, cinematic, perfect for 2am.",
                 owner: "Spotify", tracks: Array(songs.suffix(8)),
                 gradientColors: [Color(hex: "1A1A2E"), Color(hex: "0D0D0D")],
                 type: .editorial, followerCount: 3_200_000),

        Playlist(name: "Workout Energy", description: "High-energy tracks to power your session.",
                 owner: "You", tracks: Array(songs.filter { $0.isExplicit || $0.duration > 200 }),
                 gradientColors: [Color(hex: "FF4500"), Color(hex: "8B0000")],
                 type: .userCreated, followerCount: 0),

        Playlist(name: "Pop Rising", description: "The next generation of pop superstars.",
                 owner: "Spotify", tracks: Array(songs.shuffled().prefix(12)),
                 gradientColors: [Color(hex: "FF69B4"), Color(hex: "7B1FA2")],
                 type: .editorial, followerCount: 8_900_000),
    ]

    // MARK: - Search Categories
    static let searchCategories: [(name: String, colors: [Color])] = [
        ("Pop", [Color(hex: "C62828"), Color(hex: "7B1FA2")]),
        ("Hip-Hop", [Color(hex: "FF6F00"), Color(hex: "1A1A1A")]),
        ("R&B", [Color(hex: "6A1B9A"), Color(hex: "1A0033")]),
        ("Electronic", [Color(hex: "0288D1"), Color(hex: "004D70")]),
        ("Rock", [Color(hex: "212121"), Color(hex: "F57F17")]),
        ("Latin", [Color(hex: "E65100"), Color(hex: "BF360C")]),
        ("Indie", [Color(hex: "2E7D32"), Color(hex: "0A2E0B")]),
        ("Jazz", [Color(hex: "4A148C"), Color(hex: "1A0040")]),
        ("Classical", [Color(hex: "1565C0"), Color(hex: "0D1B4B")]),
        ("K-Pop", [Color(hex: "E91E8C"), Color(hex: "6A0050")]),
        ("Metal", [Color(hex: "37474F"), Color(hex: "0D0D0D")]),
        ("Country", [Color(hex: "795548"), Color(hex: "3E2723")]),
        ("Podcasts", [Color(hex: "006450"), Color(hex: "003228")]),
        ("New Releases", [Color(hex: "1DB954"), Color(hex: "006028")]),
        ("Live Events", [Color(hex: "E60026"), Color(hex: "7A0013")]),
        ("Charts", [Color(hex: "0D47A1"), Color(hex: "001C5A")]),
    ]

    // MARK: - Rooms (Vibe Rooms)
    static let rooms: [Room] = [
        Room(
            name: "Late Night Chill 🌙",
            currentMood: .lofi,
            currentSong: songs[0],
            users: [
                RoomUser(name: "alex_m", avatar: "person.fill", profileImageURL: "4ECDC4", isDJ: true, moodVote: "🌙", angle: 0),
                RoomUser(name: "sofia", avatar: "person.fill", profileImageURL: "FF6B6B", isDJ: false, moodVote: "💙", angle: 72),
                RoomUser(name: "marco_t", avatar: "person.fill", profileImageURL: "45B7D1", isDJ: false, moodVote: "🌊", angle: 144),
                RoomUser(name: "yuki", avatar: "person.fill", profileImageURL: "FFEAA7", isDJ: false, moodVote: "🌙", angle: 216),
                RoomUser(name: "priya", avatar: "person.fill", profileImageURL: "DDA0DD", isDJ: false, moodVote: nil, angle: 288),
            ],
            djQueue: [
                QueueItem(song: songs[8], proposedBy: "sofia", votes: 12),
                QueueItem(song: songs[3], proposedBy: "marco_t", votes: 7),
                QueueItem(song: songs[14], proposedBy: "yuki", votes: 4),
            ],
            isLive: true, listenerCount: 247,
            chatMessages: [
                ChatMessage(userName: "sofia", text: "this track hits different at 2am 🌙", timestamp: "11:42 PM", isMe: false),
                ChatMessage(userName: "marco_t", text: "vibes are immaculate rn", timestamp: "11:43 PM", isMe: false),
                ChatMessage(userName: "alex_m", text: "glad you guys are here ✨", timestamp: "11:44 PM", isMe: false),
                ChatMessage(userName: "yuki", text: "can we keep this energy going?", timestamp: "11:45 PM", isMe: false),
                ChatMessage(userName: "sofia", text: "who added this song? it's perfect", timestamp: "11:46 PM", isMe: false),
                ChatMessage(userName: "priya", text: "the weeknd never misses 🔥", timestamp: "11:47 PM", isMe: false),
                ChatMessage(userName: "marco_t", text: "facts!! after hours is a masterpiece", timestamp: "11:48 PM", isMe: false),
            ],
            songVoteOptions: [
                SongVoteOption(song: songs[14], voteCount: 45),
                SongVoteOption(song: songs[8], voteCount: 32),
                SongVoteOption(song: songs[18], voteCount: 23),
            ]
        ),
        Room(
            name: "Friday Energy 🔥",
            currentMood: .hype,
            currentSong: songs[6],
            users: [
                RoomUser(name: "DJ_Max", avatar: "person.fill", profileImageURL: "FF8C42", isDJ: true, moodVote: "🔥", angle: 0),
                RoomUser(name: "lisa99", avatar: "person.fill", profileImageURL: "F1948A", isDJ: false, moodVote: "🔥", angle: 60),
                RoomUser(name: "carlos", avatar: "person.fill", profileImageURL: "82E0AA", isDJ: false, moodVote: "🎉", angle: 120),
                RoomUser(name: "nadia", avatar: "person.fill", profileImageURL: "F7DC6F", isDJ: false, moodVote: "🔥", angle: 180),
                RoomUser(name: "tom_k", avatar: "person.fill", profileImageURL: "85C1E9", isDJ: false, moodVote: nil, angle: 240),
                RoomUser(name: "zee", avatar: "person.fill", profileImageURL: "BB8FCE", isDJ: false, moodVote: "💃", angle: 300),
            ],
            djQueue: [
                QueueItem(song: songs[10], proposedBy: "lisa99", votes: 31),
                QueueItem(song: songs[4], proposedBy: "carlos", votes: 18),
                QueueItem(song: songs[7], proposedBy: "nadia", votes: 9),
            ],
            isLive: true, listenerCount: 1284,
            chatMessages: [
                ChatMessage(userName: "DJ_Max", text: "FRIDAY NIGHT LET'S GOOOO 🔥🔥", timestamp: "9:00 PM", isMe: false),
                ChatMessage(userName: "lisa99", text: "the energy in here is unmatched", timestamp: "9:01 PM", isMe: false),
                ChatMessage(userName: "carlos", text: "turn it up!! 🔊", timestamp: "9:02 PM", isMe: false),
                ChatMessage(userName: "nadia", text: "this song makes me wanna dance 💃", timestamp: "9:03 PM", isMe: false),
                ChatMessage(userName: "zee", text: "best room on the app fr fr", timestamp: "9:04 PM", isMe: false),
                ChatMessage(userName: "tom_k", text: "just joined, what did I miss?", timestamp: "9:05 PM", isMe: false),
                ChatMessage(userName: "DJ_Max", text: "you missed the warmup but we're just getting started 😎", timestamp: "9:06 PM", isMe: false),
            ],
            songVoteOptions: [
                SongVoteOption(song: songs[4], voteCount: 67),
                SongVoteOption(song: songs[10], voteCount: 54),
                SongVoteOption(song: songs[7], voteCount: 31),
            ]
        ),
        Room(
            name: "Deep Focus 🧠",
            currentMood: .focus,
            currentSong: songs[18],
            users: [
                RoomUser(name: "devguru", avatar: "person.fill", profileImageURL: "96CEB4", isDJ: true, moodVote: "🧠", angle: 0),
                RoomUser(name: "anna_s", avatar: "person.fill", profileImageURL: "AED6F1", isDJ: false, moodVote: "✨", angle: 90),
                RoomUser(name: "kai", avatar: "person.fill", profileImageURL: "D7BDE2", isDJ: false, moodVote: "🎧", angle: 180),
                RoomUser(name: "elena", avatar: "person.fill", profileImageURL: "A3E4D7", isDJ: false, moodVote: "🧠", angle: 270),
            ],
            djQueue: [
                QueueItem(song: songs[19], proposedBy: "anna_s", votes: 6),
                QueueItem(song: songs[13], proposedBy: "kai", votes: 3),
            ],
            isLive: true, listenerCount: 89,
            chatMessages: [
                ChatMessage(userName: "devguru", text: "perfect study music 📚", timestamp: "3:00 PM", isMe: false),
                ChatMessage(userName: "anna_s", text: "finally found a room where I can concentrate", timestamp: "3:05 PM", isMe: false),
                ChatMessage(userName: "kai", text: "🤫 (keeping it quiet)", timestamp: "3:10 PM", isMe: false),
                ChatMessage(userName: "elena", text: "this playlist is chef's kiss for coding", timestamp: "3:15 PM", isMe: false),
                ChatMessage(userName: "devguru", text: "silk sonic always hits different when you're in the zone", timestamp: "3:20 PM", isMe: false),
            ],
            songVoteOptions: [
                SongVoteOption(song: songs[19], voteCount: 18),
                SongVoteOption(song: songs[13], voteCount: 14),
                SongVoteOption(song: songs[3], voteCount: 9),
            ]
        ),
        Room(
            name: "Pop Party 🎉",
            currentMood: .party,
            currentSong: songs[1],
            users: [
                RoomUser(name: "popqueen", avatar: "person.fill", profileImageURL: "F8C471", isDJ: true, moodVote: "🎉", angle: 0),
                RoomUser(name: "bea_f", avatar: "person.fill", profileImageURL: "FAD7A0", isDJ: false, moodVote: "💃", angle: 45),
                RoomUser(name: "riko", avatar: "person.fill", profileImageURL: "ABB2B9", isDJ: false, moodVote: "🎊", angle: 90),
                RoomUser(name: "ines", avatar: "person.fill", profileImageURL: "F0B27A", isDJ: false, moodVote: "🎉", angle: 135),
                RoomUser(name: "jake", avatar: "person.fill", profileImageURL: "98D8C8", isDJ: false, moodVote: nil, angle: 180),
                RoomUser(name: "mia", avatar: "person.fill", profileImageURL: "FF6B6B", isDJ: false, moodVote: "🔥", angle: 225),
                RoomUser(name: "sam", avatar: "person.fill", profileImageURL: "4ECDC4", isDJ: false, moodVote: "🎊", angle: 270),
                RoomUser(name: "leo", avatar: "person.fill", profileImageURL: "45B7D1", isDJ: false, moodVote: "💃", angle: 315),
            ],
            djQueue: [
                QueueItem(song: songs[2], proposedBy: "bea_f", votes: 44),
                QueueItem(song: songs[12], proposedBy: "riko", votes: 22),
                QueueItem(song: songs[16], proposedBy: "ines", votes: 11),
                QueueItem(song: songs[17], proposedBy: "mia", votes: 5),
            ],
            isLive: true, listenerCount: 3721,
            chatMessages: [
                ChatMessage(userName: "popqueen", text: "HARRY STYLES FANS RISE UP 👑", timestamp: "8:00 PM", isMe: false),
                ChatMessage(userName: "bea_f", text: "as it was is literally my anthem", timestamp: "8:01 PM", isMe: false),
                ChatMessage(userName: "riko", text: "who's going to the concert next month?!", timestamp: "8:02 PM", isMe: false),
                ChatMessage(userName: "ines", text: "me me me!! 🙋‍♀️", timestamp: "8:03 PM", isMe: false),
                ChatMessage(userName: "mia", text: "this room always has the best vibes", timestamp: "8:04 PM", isMe: false),
                ChatMessage(userName: "jake", text: "can we get some taylor swift next?", timestamp: "8:05 PM", isMe: false),
                ChatMessage(userName: "sam", text: "seconded!! anti-hero please 🙏", timestamp: "8:06 PM", isMe: false),
                ChatMessage(userName: "leo", text: "the queue is looking fire tonight 🔥", timestamp: "8:07 PM", isMe: false),
            ],
            songVoteOptions: [
                SongVoteOption(song: songs[2], voteCount: 89),
                SongVoteOption(song: songs[16], voteCount: 72),
                SongVoteOption(song: songs[12], voteCount: 45),
            ]
        ),
        Room(
            name: "Romantic Evening 💫",
            currentMood: .romantic,
            currentSong: songs[18],
            users: [
                RoomUser(name: "lover_x", avatar: "person.fill", profileImageURL: "FFB3C6", isDJ: true, moodVote: "💫", angle: 0),
                RoomUser(name: "rose_m", avatar: "person.fill", profileImageURL: "DDA0DD", isDJ: false, moodVote: "💗", angle: 120),
                RoomUser(name: "dante", avatar: "person.fill", profileImageURL: "F1948A", isDJ: false, moodVote: "💫", angle: 240),
            ],
            djQueue: [
                QueueItem(song: songs[11], proposedBy: "rose_m", votes: 8),
                QueueItem(song: songs[9], proposedBy: "dante", votes: 5),
            ],
            isLive: false, listenerCount: 43,
            chatMessages: [
                ChatMessage(userName: "lover_x", text: "silk sonic is pure romance 💫", timestamp: "10:00 PM", isMe: false),
                ChatMessage(userName: "rose_m", text: "this room is so cozy 🕯️", timestamp: "10:05 PM", isMe: false),
                ChatMessage(userName: "dante", text: "dedicated to everyone listening tonight ❤️", timestamp: "10:10 PM", isMe: false),
                ChatMessage(userName: "lover_x", text: "leave the door open is the perfect song for this mood", timestamp: "10:15 PM", isMe: false),
                ChatMessage(userName: "rose_m", text: "whoever made this room, thank you 🙏", timestamp: "10:20 PM", isMe: false),
            ],
            songVoteOptions: [
                SongVoteOption(song: songs[11], voteCount: 22),
                SongVoteOption(song: songs[1], voteCount: 18),
                SongVoteOption(song: songs[15], voteCount: 12),
            ]
        ),
        Room(
            name: "Sad Hours 🫧",
            currentMood: .sad,
            currentSong: songs[14],
            users: [
                RoomUser(name: "melancholy_kid", avatar: "person.fill", profileImageURL: "90CAF9", isDJ: true, moodVote: "🫧", angle: 0),
                RoomUser(name: "rainy_daze", avatar: "person.fill", profileImageURL: "B39DDB", isDJ: false, moodVote: "💙", angle: 90),
                RoomUser(name: "luna_m", avatar: "person.fill", profileImageURL: "80DEEA", isDJ: false, moodVote: "🌧️", angle: 180),
                RoomUser(name: "quiet_storm", avatar: "person.fill", profileImageURL: "CE93D8", isDJ: false, moodVote: "🫧", angle: 270),
            ],
            djQueue: [
                QueueItem(song: songs[7], proposedBy: "rainy_daze", votes: 14),
                QueueItem(song: songs[9], proposedBy: "luna_m", votes: 8),
            ],
            isLive: true, listenerCount: 156,
            chatMessages: [
                ChatMessage(userName: "melancholy_kid", text: "this song understands me 💔", timestamp: "10:15 PM", isMe: false),
                ChatMessage(userName: "rainy_daze", text: "it's one of those nights...", timestamp: "10:16 PM", isMe: false),
                ChatMessage(userName: "luna_m", text: "sending virtual hugs to everyone here 🫂", timestamp: "10:17 PM", isMe: false),
                ChatMessage(userName: "quiet_storm", text: "olivia rodrigo hits different when it rains", timestamp: "10:18 PM", isMe: false),
                ChatMessage(userName: "rainy_daze", text: "the room name really checks out huh", timestamp: "10:19 PM", isMe: false),
            ],
            songVoteOptions: [
                SongVoteOption(song: songs[9], voteCount: 38),
                SongVoteOption(song: songs[7], voteCount: 29),
                SongVoteOption(song: songs[14], voteCount: 18),
            ]
        ),
        Room(
            name: "Workout Beast 💪",
            currentMood: .hype,
            currentSong: songs[10],
            users: [
                RoomUser(name: "gym_rat", avatar: "person.fill", profileImageURL: "EF5350", isDJ: true, moodVote: "🔥", angle: 0),
                RoomUser(name: "iron_mike", avatar: "person.fill", profileImageURL: "FF7043", isDJ: false, moodVote: "💪", angle: 72),
                RoomUser(name: "cardio_queen", avatar: "person.fill", profileImageURL: "EC407A", isDJ: false, moodVote: "🔥", angle: 144),
                RoomUser(name: "lift_heavy", avatar: "person.fill", profileImageURL: "AB47BC", isDJ: false, moodVote: "💪", angle: 216),
                RoomUser(name: "runner_x", avatar: "person.fill", profileImageURL: "42A5F5", isDJ: false, moodVote: nil, angle: 288),
            ],
            djQueue: [
                QueueItem(song: songs[4], proposedBy: "iron_mike", votes: 22),
                QueueItem(song: songs[6], proposedBy: "cardio_queen", votes: 15),
            ],
            isLive: true, listenerCount: 412,
            chatMessages: [
                ChatMessage(userName: "gym_rat", text: "let's gooo 💪🔥", timestamp: "6:30 AM", isMe: false),
                ChatMessage(userName: "iron_mike", text: "PR day today who's with me", timestamp: "6:31 AM", isMe: false),
                ChatMessage(userName: "cardio_queen", text: "this beat is insane for running", timestamp: "6:32 AM", isMe: false),
                ChatMessage(userName: "lift_heavy", text: "need more bass drops 🎵", timestamp: "6:33 AM", isMe: false),
                ChatMessage(userName: "runner_x", text: "5 miles in and still going strong", timestamp: "6:34 AM", isMe: false),
                ChatMessage(userName: "gym_rat", text: "that's the energy we need!!", timestamp: "6:35 AM", isMe: false),
            ],
            songVoteOptions: [
                SongVoteOption(song: songs[10], voteCount: 52),
                SongVoteOption(song: songs[4], voteCount: 41),
                SongVoteOption(song: songs[6], voteCount: 28),
            ]
        ),
    ]

    // MARK: - Podcasts
    static let podcasts: [Podcast] = [
        Podcast(title: "The Daily", author: "The New York Times",
                description: "This is what the news should sound like.",
                episodes: [
                    PodcastEpisode(title: "The Biggest Story of the Year", description: "We recap the most important moments.", duration: 2400, publishedDate: "Today", isPlayed: false),
                    PodcastEpisode(title: "What's Next for Tech", description: "A look at emerging technologies.", duration: 1800, publishedDate: "Yesterday", isPlayed: true),
                ],
                gradientColors: [Color(hex: "1A1A1A"), Color(hex: "2C2C2C")]),

        Podcast(title: "Huberman Lab", author: "Andrew Huberman",
                description: "Science-based tools for everyday life.",
                episodes: [
                    PodcastEpisode(title: "How to Optimize Sleep", description: "Science-backed protocols for better sleep.", duration: 7200, publishedDate: "2 days ago", isPlayed: false),
                    PodcastEpisode(title: "Master Your Focus", description: "Neuroscience of concentration and deep work.", duration: 6800, publishedDate: "1 week ago", isPlayed: true),
                ],
                gradientColors: [Color(hex: "1B5E20"), Color(hex: "0A1F0D")]),

        Podcast(title: "Crime Junkie", author: "audiochuck",
                description: "If you can never get enough true crime, this is the show for you.",
                episodes: [
                    PodcastEpisode(title: "The Vanishing", description: "A cold case reopened.", duration: 3200, publishedDate: "3 days ago", isPlayed: false),
                ],
                gradientColors: [Color(hex: "4A148C"), Color(hex: "1A0040")]),
    ]

    // MARK: - Liked Songs Playlist shortcut
    static var likedSongs: Playlist {
        playlists.first { $0.type == .liked } ?? playlists[0]
    }

    static var recentlyPlayed: [Song] {
        Array(songs.prefix(6))
    }

    static var madeForYou: [Playlist] {
        Array(playlists.filter { $0.type == .madeForYou })
    }

    static var featuredPlaylists: [Playlist] {
        Array(playlists.filter { $0.type == .editorial })
    }
}

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
                RoomUser(name: "alex_m", avatar: "person.fill", isDJ: true, moodVote: "🌙", angle: 0),
                RoomUser(name: "sofia", avatar: "person.fill", isDJ: false, moodVote: "💙", angle: 72),
                RoomUser(name: "marco_t", avatar: "person.fill", isDJ: false, moodVote: "🌊", angle: 144),
                RoomUser(name: "yuki", avatar: "person.fill", isDJ: false, moodVote: "🌙", angle: 216),
                RoomUser(name: "priya", avatar: "person.fill", isDJ: false, moodVote: nil, angle: 288),
            ],
            djQueue: [
                QueueItem(song: songs[8], proposedBy: "sofia", votes: 12),
                QueueItem(song: songs[3], proposedBy: "marco_t", votes: 7),
                QueueItem(song: songs[14], proposedBy: "yuki", votes: 4),
            ],
            isLive: true, listenerCount: 247
        ),
        Room(
            name: "Friday Energy 🔥",
            currentMood: .hype,
            currentSong: songs[6],
            users: [
                RoomUser(name: "DJ_Max", avatar: "person.fill", isDJ: true, moodVote: "🔥", angle: 0),
                RoomUser(name: "lisa99", avatar: "person.fill", isDJ: false, moodVote: "🔥", angle: 60),
                RoomUser(name: "carlos", avatar: "person.fill", isDJ: false, moodVote: "🎉", angle: 120),
                RoomUser(name: "nadia", avatar: "person.fill", isDJ: false, moodVote: "🔥", angle: 180),
                RoomUser(name: "tom_k", avatar: "person.fill", isDJ: false, moodVote: nil, angle: 240),
                RoomUser(name: "zee", avatar: "person.fill", isDJ: false, moodVote: "💃", angle: 300),
            ],
            djQueue: [
                QueueItem(song: songs[10], proposedBy: "lisa99", votes: 31),
                QueueItem(song: songs[4], proposedBy: "carlos", votes: 18),
                QueueItem(song: songs[7], proposedBy: "nadia", votes: 9),
            ],
            isLive: true, listenerCount: 1284
        ),
        Room(
            name: "Deep Focus 🧠",
            currentMood: .focus,
            currentSong: songs[18],
            users: [
                RoomUser(name: "devguru", avatar: "person.fill", isDJ: true, moodVote: "🧠", angle: 0),
                RoomUser(name: "anna_s", avatar: "person.fill", isDJ: false, moodVote: "✨", angle: 90),
                RoomUser(name: "kai", avatar: "person.fill", isDJ: false, moodVote: "🎧", angle: 180),
                RoomUser(name: "elena", avatar: "person.fill", isDJ: false, moodVote: "🧠", angle: 270),
            ],
            djQueue: [
                QueueItem(song: songs[19], proposedBy: "anna_s", votes: 6),
                QueueItem(song: songs[13], proposedBy: "kai", votes: 3),
            ],
            isLive: true, listenerCount: 89
        ),
        Room(
            name: "Pop Party 🎉",
            currentMood: .party,
            currentSong: songs[1],
            users: [
                RoomUser(name: "popqueen", avatar: "person.fill", isDJ: true, moodVote: "🎉", angle: 0),
                RoomUser(name: "bea_f", avatar: "person.fill", isDJ: false, moodVote: "💃", angle: 45),
                RoomUser(name: "riko", avatar: "person.fill", isDJ: false, moodVote: "🎊", angle: 90),
                RoomUser(name: "ines", avatar: "person.fill", isDJ: false, moodVote: "🎉", angle: 135),
                RoomUser(name: "jake", avatar: "person.fill", isDJ: false, moodVote: nil, angle: 180),
                RoomUser(name: "mia", avatar: "person.fill", isDJ: false, moodVote: "🔥", angle: 225),
                RoomUser(name: "sam", avatar: "person.fill", isDJ: false, moodVote: "🎊", angle: 270),
                RoomUser(name: "leo", avatar: "person.fill", isDJ: false, moodVote: "💃", angle: 315),
            ],
            djQueue: [
                QueueItem(song: songs[2], proposedBy: "bea_f", votes: 44),
                QueueItem(song: songs[12], proposedBy: "riko", votes: 22),
                QueueItem(song: songs[16], proposedBy: "ines", votes: 11),
                QueueItem(song: songs[17], proposedBy: "mia", votes: 5),
            ],
            isLive: true, listenerCount: 3721
        ),
        Room(
            name: "Romantic Evening 💫",
            currentMood: .romantic,
            currentSong: songs[18],
            users: [
                RoomUser(name: "lover_x", avatar: "person.fill", isDJ: true, moodVote: "💫", angle: 0),
                RoomUser(name: "rose_m", avatar: "person.fill", isDJ: false, moodVote: "💗", angle: 120),
                RoomUser(name: "dante", avatar: "person.fill", isDJ: false, moodVote: "💫", angle: 240),
            ],
            djQueue: [
                QueueItem(song: songs[11], proposedBy: "rose_m", votes: 8),
                QueueItem(song: songs[9], proposedBy: "dante", votes: 5),
            ],
            isLive: false, listenerCount: 43
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

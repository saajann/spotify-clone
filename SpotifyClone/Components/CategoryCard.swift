// CategoryCard.swift
// SpotifyClone

import SwiftUI

struct CategoryCard: View {
    let name: String
    let colors: [Color]

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 8)
                .fill(LinearGradient(
                    colors: colors,
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .frame(height: 100)

            Text(name)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.white)
                .padding(12)
        }
    }
}

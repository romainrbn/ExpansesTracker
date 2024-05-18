//
//  LogItemView.swift
//  AIExpansesTracker
//
//  Created by Romain Rabouan on 09/05/2024.
//

import SwiftUI

struct LogItemView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    let log: ExpanseLog

    var body: some View {
        switch horizontalSizeClass {
        case .compact: compactView
        default: regularView
        }
    }

    private var compactView: some View {
        HStack(spacing: 16) {
            CategoryImageView(category: log.categoryEnum)

            VStack(alignment: .leading, spacing: 8) {
                Text(log.name)
                    .font(.headline)

                Text(log.dateText)
                    .font(.subheadline)
            }

            Spacer()

            Text(log.amountText)
                .font(.headline)
        }
    }

    private var regularView: some View {
        HStack(spacing: 16) {
            CategoryImageView(category: log.categoryEnum)
            Spacer()
            Text(log.name)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)

            Spacer()

            Text(log.amountText)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)

            Spacer()

            Text(log.dateText)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)

            Spacer()

            Text(log.categoryEnum.rawValue.capitalized)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)

            Spacer()
        }
    }
}

#Preview {
    VStack {
        ForEach(
            [
                ExpanseLog(id: "1", name: "Sushi", category: "Food", amount: 10, date: .now),
                ExpanseLog(id: "2", name: "Electricity", category: "Utilities", amount: 50, date: .now),
            ]
        ) { log in
            LogItemView(log: log)
        }
    }
    .padding()
}

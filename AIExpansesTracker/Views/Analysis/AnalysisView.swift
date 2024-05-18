//
//  AnalysisView.swift
//  AIExpansesTracker
//
//  Created by Romain Rabouan on 09/05/2024.
//

import SwiftUI
import FirebaseFirestore
import Charts

struct AnalysisView: View {
    @State private var viewModel = AnalysisViewModel()

    @FirestoreQuery(
        collectionPath: "logs",
        predicates: [.order(by: SortType.date.rawValue, descending: true)]
    )

    private var logs: [ExpanseLog]

    private var mappedLogs: [(amount: Double, category: Category)] {
        let counts = logs.reduce(into: [Category: Double]()) { dict, log in
            dict[log.categoryEnum, default: 0] += log.amount
        }

        return counts.map { (amount: $1, category: $0) }
    }

    private var totalSpent: Double {
        return logs.reduce(0.0) { sum, log in
            sum + log.amount
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Total Dépensé ce mois-ci")
                                .font(.subheadline)

                            Text(totalSpent, format: .currency(code: "EUR"))
                                .font(.system(.title, design: .rounded, weight: .bold))
                        }
                        Spacer()
                    }

                    Chart {
                        ForEach(mappedLogs, id: \.category) { logCount in
                            BarMark(
                                x: .value("Category", logCount.category.rawValue.capitalized),
                                y: .value("Number of expanses", logCount.amount)
                            )
                            .foregroundStyle(logCount.category.color)
                        }
                    }
                    .chartXAxis(.hidden)
                    .chartLegend(.visible)

                    Chart(mappedLogs, id: \.category) { logCount in
                        SectorMark(
                            angle: .value("Expanses", logCount.amount),
                            innerRadius: .ratio(0.5),
                            angularInset: 1.5
                        )
                        .foregroundStyle(logCount.category.color)
                    }
                    .frame(height: 250)
                    .padding()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
            .navigationBarTitle("Analyse", displayMode: .inline)
        }
    }
}


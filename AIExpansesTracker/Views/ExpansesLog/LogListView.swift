//
//  LogListView.swift
//  AIExpansesTracker
//
//  Created by Romain Rabouan on 09/05/2024.
//

import FirebaseFirestore
import SwiftUI

struct LogListView: View {

    @Binding var viewModel: LogListViewModel

    @FirestoreQuery(
        collectionPath: "logs",
        predicates: [.order(by: SortType.date.rawValue, descending: true)]
    )

    private var logs: [ExpanseLog]

    var body: some View {
        listView
            .sheet(item: $viewModel.logToEdit) {
                viewModel.logToEdit = nil
            } content: { log in
                LogFormView(viewModel: .init(logToEdit: log))
            }
            .overlay {
                if logs.isEmpty {
                    #if !os(macOS)
                    ContentUnavailableView(buildEmptyViewTitle(), systemImage: "eurosign")
                    #else
                    Text("Pas de dépenses enregistrées.")
                        .multilineTextAlignment(.center)
                        .font(.headline)
                        .padding(.horizontal)
                    #endif
                }
            }
            .onChange(of: viewModel.sortType) {
                updateFirestoreQuery()
            }
            .onChange(of: viewModel.sortOrder) {
                updateFirestoreQuery()
            }
            .onChange(of: viewModel.selectedCategories) {
                updateFirestoreQuery()
            }
    }

    var listView: some View {
        #if os(iOS)
        List {
            ForEach(logs) { log in
                LogItemView(log: log)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        viewModel.logToEdit = log
                    }
                    .padding(.vertical, 4)
            }
            .onDelete(perform: self.onDelete)
        }
        .listStyle(.plain)
        #else
        ZStack {
            ScrollView {
                ForEach(logs) { log in
                    VStack {
                        LogItemView(log: log)
                        Divider()
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .contentShape(Rectangle())
                    .padding(.horizontal)
                    .onTapGesture {
                        self.viewModel.logToEdit = log
                    }
                    .contextMenu {
                        Button("Modifier") {
                            self.viewModel.logToEdit = log
                        }

                        Button("Supprimer") {
                            self.viewModel.db.delete(log: log)
                        }
                    }
                }
            }
            .contentMargins(.vertical, 8, for: .scrollContent)
        }
        #endif
    }

    private func buildEmptyViewTitle() -> String {
        var title = "Pas de dépenses enregistrées"

        if viewModel.selectedCategories.isEmpty == false {
            title += " avec ces filtres."
        } else {
            title += "."
        }

        return title
    }

    private func updateFirestoreQuery() {
        $logs.predicates = viewModel.predicates
    }

    private func onDelete(with indexSet: IndexSet) {
        indexSet.forEach { index in
            let log = logs[index]
            viewModel.db.delete(log: log)
        }
    }
}

#Preview {
    @State var vm = LogListViewModel()
    return LogListView(viewModel: $vm)
    #if os(macOS)
        .frame(width: 700)
    #endif
}

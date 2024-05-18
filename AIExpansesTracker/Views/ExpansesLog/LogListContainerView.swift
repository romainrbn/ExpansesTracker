//
//  LogListContainerView.swift
//  AIExpansesTracker
//
//  Created by Romain Rabouan on 09/05/2024.
//

import SwiftUI

struct LogListContainerView: View {

    @Binding var viewModel: LogListViewModel

    var body: some View {
        VStack(spacing: 0) {
            FilterCategoriesView(selectedCategories: $viewModel.selectedCategories)
            Divider()
            SelectSortOrderView(sortType: $viewModel.sortType, sortOrder: $viewModel.sortOrder)
            Divider()
            LogListView(viewModel: $viewModel)
        }
        .toolbar {
            if viewModel.selectedCategories.isEmpty == false {
                #if os(macOS)
                ToolbarItem {
                    Button {
                        viewModel.selectedCategories.removeAll()
                    } label: {
                        Text("Effacer les filtres")
                    }
                }
                #else
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        viewModel.selectedCategories.removeAll()
                    } label: {
                        Text("Reinit.")
                    }
                }
                #endif
            }

            ToolbarItem {
                Button {
                    viewModel.isLogFormPresented = true
                } label: {
                    #if os(macOS)
                    HStack {
                        Image(systemName: "plus")
                            .symbolRenderingMode(.monochrome)
                            .tint(.accentColor)
                        Text("Ajouter une dépense")
                    }
                    .foregroundStyle(Color.accentColor)
                    #else
                    Text("Ajouter")
                    #endif
                }
            }
        }
        .sheet(isPresented: $viewModel.isLogFormPresented) {
            LogFormView(viewModel: .init())
        }
        #if !os(macOS)
        .navigationBarTitle("Suivi des dépenses", displayMode: .inline)
        #endif
    }
}

#Preview {
    @State var vm = LogListViewModel()
    return NavigationStack {
        LogListContainerView(viewModel: $vm)
    }
}

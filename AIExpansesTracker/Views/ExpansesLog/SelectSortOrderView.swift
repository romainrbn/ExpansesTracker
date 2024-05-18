//
//  SelectSortOrderView.swift
//  AIExpansesTracker
//
//  Created by Romain Rabouan on 09/05/2024.
//

import SwiftUI

struct SelectSortOrderView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    @Binding var sortType: SortType
    @Binding var sortOrder: SortOrder

    private let sortTypes = SortType.allCases
    private let sortOrders = SortOrder.allCases

    var body: some View {
        HStack {
            #if !os(macOS)
            Text("Trier par")
            #endif

            Picker(selection: $sortType) {
                ForEach(sortTypes) { type in
                    if horizontalSizeClass == .compact {
                        Image(systemName: type.systemNameIcon)
                            .tag(type)
                    } else {
                        Text(type.name.capitalized)
                            .tag(type)
                    }
                }
            } label: {
                Text("Trier par")
            }
            .pickerStyle(.segmented)

            Picker(selection: $sortOrder) {
                ForEach(sortOrders) { order in
                    if horizontalSizeClass == .compact {
                        Image(systemName: order == .ascending ? "arrow.up" : "arrow.down")
                            .tag(order)
                    } else {
                        Text(order.name.capitalized)
                            .tag(order)
                    }
                }
            } label: {
                Text("Organiser par")
            }
            .pickerStyle(.segmented)

        }
        .padding()
        .frame(height: 64)
    }
}

#Preview {
    @State var vm = LogListViewModel()
    return SelectSortOrderView(sortType: $vm.sortType, sortOrder: $vm.sortOrder)
}

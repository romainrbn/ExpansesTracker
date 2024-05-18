//
//  FilterCategoriesView.swift
//  AIExpansesTracker
//
//  Created by Romain Rabouan on 09/05/2024.
//

import SwiftUI

struct FilterCategoriesView: View {
    @Binding var selectedCategories: Set<Category>
    private let categories = Category.allCases

    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(categories) { category in
                        FilterButtonView(
                            category: category,
                            isSelected: self.selectedCategories.contains(category),
                            onTap: onTap
                        )
                    }
                }
                .padding(.horizontal)
            }
        }
    }

    func onTap(category: Category) {
        if selectedCategories.contains(category) {
            selectedCategories.remove(category)
        } else {
            selectedCategories.insert(category)
        }
    }
}

private struct FilterButtonView: View {
    var category: Category
    var isSelected: Bool
    var onTap: (Category) -> Void

    var body: some View {
        HStack(spacing: 4) {
            Label(category.rawValue.capitalized, systemImage: category.systemNameIcon)
                .fixedSize(horizontal: true, vertical: true)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 4)
        .background {
            RoundedRectangle(cornerRadius: 16)
                .stroke(isSelected ? category.color : Color.gray, lineWidth: 1)
                .overlay {
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundStyle(isSelected ? category.color : Color.clear)
                }
        }
        .frame(height: 44)
        .onTapGesture {
            onTap(category)
        }
        .foregroundStyle(isSelected ? .white : .primary)
    }
}

#Preview {
    @State var vm = LogListViewModel()
    return FilterCategoriesView(selectedCategories: $vm.selectedCategories)
}

//
//  LogListViewModel.swift
//  AIExpansesTracker
//
//  Created by Romain Rabouan on 09/05/2024.
//

import Foundation
import FirebaseFirestore
import Observation

@Observable
final class LogListViewModel {
    let db = DatabaseManager.shared

    var sortType = SortType.date
    var sortOrder = SortOrder.descending
    var selectedCategories = Set<Category>()

    var isLogFormPresented = false
    var logToEdit: ExpanseLog?

    var predicates: [QueryPredicate] {
        var predicates: [QueryPredicate] = []
        if selectedCategories.isEmpty == false {
            predicates.append(.whereField("category", isIn: Array(selectedCategories).map { $0.rawValue }))
        }
        predicates.append(.order(by: sortType.rawValue, descending: sortOrder == .descending))
        return predicates
    }
}

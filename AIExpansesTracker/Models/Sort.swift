//
//  Sort.swift
//  AIExpansesTracker
//
//  Created by Romain Rabouan on 09/05/2024.
//

import Foundation

enum SortType: String, Identifiable, CaseIterable {
    var id: Self { self }
    case date, amount, name

    var systemNameIcon: String {
        switch self {
        case .date:
            return "calendar"
        case .amount:
            return "eurosign.circle"
        case .name:
            return "a"
        }
    }

    var name: String {
        switch self {
        case .date:
            return "Date"
        case .amount:
            return "Montant"
        case .name:
            return "Nom"
        }
    }
}

enum SortOrder: String, Identifiable, CaseIterable {
    var id: Self { self }
    case ascending, descending

    var name: String {
        switch self {
        case .ascending:
            return "Ascendant"
        case .descending:
            return "Descendant"
        }
    }
}

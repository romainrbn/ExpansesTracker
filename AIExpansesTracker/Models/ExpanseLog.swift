//
//  ExpanseLog.swift
//  AIExpansesTracker
//
//  Created by Romain Rabouan on 09/05/2024.
//

import Foundation

struct ExpanseLog: Codable, Identifiable, Equatable {
    let id: String
    var name: String
    var category: String
    var amount: Double
    var currency: String
    var date: Date

    var categoryEnum: Category {
        Category(rawValue: category) ?? .utilities
    }

    init(id: String, name: String, category: String, amount: Double, currency: String = "EUR", date: Date) {
        self.id = id
        self.name = name
        self.category = category
        self.amount = amount
        self.currency = currency
        self.date = date
    }
}

extension ExpanseLog {
    var dateText: String {
        Utils.dateFormatter.string(from: date)
    }

    var amountText: String {
        Utils.numberFormatter.currencySymbol = currency
        return Utils.numberFormatter.string(from: NSNumber(value: amount)) ?? "\(amount)"
    }
}

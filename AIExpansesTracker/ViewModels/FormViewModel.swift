//
//  FormViewModel.swift
//  AIExpansesTracker
//
//  Created by Romain Rabouan on 09/05/2024.
//

import Foundation

@Observable
final class FormViewModel {
    var logToEdit: ExpanseLog?

    @ObservationIgnored
    let db = DatabaseManager.shared

    var name = ""
    var amount: Double = 0
    var category: Category = .utilities
    var date = Date.now

    var isSaveButtonDisabled: Bool {
        name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.isLenient = true
        formatter.numberStyle = .currency
        formatter.currencyCode = "EUR"
        return formatter
    }()

    init(logToEdit: ExpanseLog? = nil) {
        self.logToEdit = logToEdit
        if let logToEdit {
            self.name = logToEdit.name
            self.amount = logToEdit.amount
            self.category = logToEdit.categoryEnum
            self.date = logToEdit.date
            numberFormatter.currencyCode = logToEdit.currency
        }
    }

    func save() {
        var log: ExpanseLog

        if let logToEdit {
            log = logToEdit
        } else {
            log = ExpanseLog(id: UUID().uuidString, name: "", category: "", amount: 0, date: .now)
        }

        log.name = self.name.trimmingCharacters(in: .whitespacesAndNewlines)
        log.category = self.category.rawValue
        log.amount = self.amount
        log.date = self.date

        if self.logToEdit == nil {
            try? db.add(log: log)
        } else {
            db.update(log: log)
        }
    }

    func delete(log: ExpanseLog) {
        db.delete(log: log)
    }
}

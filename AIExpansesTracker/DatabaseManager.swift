//
//  DatabaseManager.swift
//  AIExpansesTracker
//
//  Created by Romain Rabouan on 09/05/2024.
//

import Foundation
import FirebaseFirestore

final class DatabaseManager {
    static let shared = DatabaseManager()

    private init() {}

    private(set) lazy var logsCollection: CollectionReference = {
        Firestore.firestore().collection("logs")
    }()

    func add(log: ExpanseLog) throws {
        try logsCollection.document(log.id).setData(from: log)
    }

    func update(log: ExpanseLog) {
        logsCollection.document(log.id).updateData([
            "name": log.name,
            "amount": log.amount,
            "category": log.category,
            "date": log.date,
        ])
    }

    func delete(log: ExpanseLog) {
        logsCollection.document(log.id).delete()
    }
}

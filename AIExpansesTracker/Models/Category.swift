//
//  Category.swift
//  AIExpansesTracker
//
//  Created by Romain Rabouan on 09/05/2024.
//

import Foundation
import Charts
import SwiftUI

enum Category: String, Identifiable, CaseIterable, Plottable {
    var id: Self { self }

    case rent = "Loyer"
    case utilities = "Utilitaires (électricité, internet...)"
    case groceries = "Courses"
    case diningOut = "Restaurants"
    case transportation = "Transports"
    case vehicle = "Voiture"
    case insurance = "Assurance"
    case health = "Santé"
    case personalCare = "Soins personnels"
    case entertainment = "Divertissement"
    case travel = "Voyages"
    case shopping = "Shopping"
    case gifts = "Cadeaux"
    case savings = "Économies"
    case taxes = "Impôts"
    case deptRepayment = "Rembours. emprunts"
    case subscriptions = "Abonnements"
    case home = "Appartement"
    case misc = "Divers"

    var systemNameIcon: String {
        switch self {
        case .rent: return "house"
        case .utilities: return "globe"
        case .groceries: return "basket"
        case .diningOut: return "fork.knife"
        case .transportation: return "bus.fill"
        case .vehicle: return "car"
        case .insurance: return "shield.checkered"
        case .health: return "heart.fill"
        case .personalCare: return "heart.text.square.fill"
        case .entertainment: return "tv.inset.filled"
        case .travel: return "airplane"
        case .shopping: return "hanger"
        case .gifts: return "gift.fill"
        case .savings: return "eurosign.square"
        case .taxes: return "eurosign.square"
        case .deptRepayment: return "building.columns"
        case .subscriptions: return "eurosign.arrow.circlepath"
        case .home: return "building.2.fill"
        case .misc: return "questionmark.square.fill"
        }
    }

    var color: Color {
        switch self {
        case .rent: return Color(hex: "#4A90E2")
        case .utilities: return Color(hex: "#F5A623")
        case .groceries: return Color(hex: "#7ED321")
        case .diningOut: return Color(hex: "#D0011B")
        case .transportation: return Color(hex: "#417505")
        case .vehicle: return Color(hex: "#C19A6B")
        case .insurance: return Color(hex: "#4A235A")
        case .health: return Color(hex: "#E74C3C")
        case .personalCare: return Color(hex: "#F1948A")
        case .entertainment: return Color(hex: "#8E44AD")
        case .travel: return Color(hex: "#3498DB")
        case .shopping: return Color(hex: "#F39C12")
        case .gifts: return Color(hex: "#EC7063")
        case .savings: return Color(hex: "#2ECC71")
        case .taxes: return Color(hex: "#34495E")
        case .deptRepayment: return Color(hex: "#B3B6B7")
        case .subscriptions: return Color(hex: "#F39C12")
        case .home: return Color(hex: "#9B59B6")
        case .misc: return Color(hex: "#7F8C8D")
        }
    }
}

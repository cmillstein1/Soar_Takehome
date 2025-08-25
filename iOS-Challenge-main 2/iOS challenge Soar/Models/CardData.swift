//
//  CardData.swift
//  Soar iOS challenge
//
//  Created by Stanley Virgint on 8/22/25.
//

import Foundation

struct CardData {
    let id: UUID
    let title: String
    let subtitle: String
    let frontContent: String
    let backContent: String
    
    init(title: String, subtitle: String, frontContent: String, backContent: String) {
        self.id = UUID()
        self.title = title
        self.subtitle = subtitle
        self.frontContent = frontContent
        self.backContent = backContent
    }
}

// MARK: - Sample Data
extension CardData {
    static let sample = CardData(
        title: "Chase Freedom",
        subtitle: "•••• 1234",
        frontContent: "Cashback rewards on every purchase. No annual fee.",
        backContent: "Balance: $2,847.32\nAvailable Credit: $7,152.68\nNext Payment: Dec 15"
    )
}

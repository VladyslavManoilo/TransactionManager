//
//  PaymentCard.swift
//  TransactionManager
//
//  Created by DeveloperMB2020 on 17.06.2024.
//

import Foundation

struct PaymentCard: Codable, Identifiable {
    let id: String
    let cardLast4: String
    let cardName: String
    let isLocked: Bool
    let isTerminated: Bool
    let spent: Int
    let limit: Int
    let limitType: String
    let cardHolder: CardHolder
    let fundingSource: String
    let issuedAt: Date
}

struct CardHolder: Codable {
    let id: String
    let fullName: String
    let email: String
    let logoUrl: String
}

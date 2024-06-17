//
//  Transaction.swift
//  TransactionManager
//
//  Created by DeveloperMB2020 on 17.06.2024.
//

import Foundation

struct Transaction: Codable, Identifiable {
    let id: String
    let tribeTransactionId: String
    let tribeCardId: Int
    let amount: String
    let status: TransactionStatus
    let tribeTransactionType: TribeTransactionType
    let schemeId: String
    let merchantName: String
    let pan: String
}

enum TribeTransactionType: String, Codable {
    case income
    case withdrawal
}

enum TransactionStatus: String, Codable {
    case successed
    case pending
    case cancelled
    case failed
}

extension Transaction: TransactionInfo {
    var last4: String {
        return pan
    }
}

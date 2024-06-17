//
//  ApiManager.swift
//  TransactionManager
//
//  Created by DeveloperMB2020 on 17.06.2024.
//

import Foundation

protocol ApiManager {
    func fetchBalance() async -> Result<Balance, ApiError>
    func fetchCards() async -> Result<[PaymentCard], ApiError>
    func fetchTransactions() async -> Result<[Transaction], ApiError>
}


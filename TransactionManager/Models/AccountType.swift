//
//  AccountType.swift
//  TransactionManager
//
//  Created by DeveloperMB2020 on 17.06.2024.
//

import SwiftUI

enum AccountType {
    case eu
}

extension AccountType {
    var currencySymbol: String {
        switch self {
        case .eu:
            return "€"
        }
    }
    
    var currency: String {
        switch self {
        case .eu:
            return "EUR"
        }
    }
    
    var logo: String {
        switch self {
        case .eu:
            return "🇪🇺"
        }
    }
}

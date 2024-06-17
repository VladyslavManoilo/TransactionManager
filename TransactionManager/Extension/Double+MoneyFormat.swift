//
//  Double+MoneyFormat.swift
//  TransactionManager
//
//  Created by DeveloperMB2020 on 17.06.2024.
//

import Foundation

extension Double {
    func moneyString(currencySymbol: String) -> String? {
        let formatter = NumberFormatter.moneyNumberFormatter
        formatter.currencySymbol = currencySymbol
        
        if let formattedAmount = formatter.string(from: NSNumber(value: self)) {
            return formattedAmount
        }
        
        return nil
    }
}

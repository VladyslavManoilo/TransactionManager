//
//  WithdrawViewModel.swift
//  TransactionManager
//
//  Created by DeveloperMB2020 on 17.06.2024.
//

import Foundation

final class WithdrawViewModel: ObservableObject {
    let currency: String
    let balance: Double
    let withdrawCancelled: VoidClosure
    let withdrawFinished: VoidClosure

    var isWithdrawAvailable: Bool {
        guard let amount = amount else {
            return false
        }
        return (amount > 0) && (amount <= balance)
    }
    var isAmountAvailable: Bool {
        let amount = amount ?? 0
        return amount <= balance
    }
   
    @Published var amount: Double?
    
    @Published var amountText: String = ""
        
    var balanceString: String {
        return balance.moneyString(currencySymbol: currency) ?? ""
    }
    
    init(currency: String, balance: Double, withdrawCancelled: @escaping VoidClosure, withdrawFinished: @escaping VoidClosure) {
        self.currency = currency
        self.balance = balance
        self.withdrawCancelled = withdrawCancelled
        self.withdrawFinished = withdrawFinished
    }

    func withdrawalProcessed() {
        // TODO: put there some withdraw request or something if needed
        withdrawFinished()
    }

    func formateAmount(_ newAmountText: String, oldValue: String) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.roundingMode = .floor
        
        let cleanAmountString = newAmountText.replacingOccurrences(of: formatter.groupingSeparator, with: "")
        let newAmount = formatter.number(from: cleanAmountString)?.doubleValue
        amount = newAmount
        if let newAmount = newAmount {
            if let lastSymbol = cleanAmountString.last, String(lastSymbol) == formatter.decimalSeparator {
                amountText = newAmountText
                return
            }
            amountText = formatter.string(from: NSNumber(value: newAmount)) ?? oldValue
        } else {
            amountText = ""
        }
  
    }
}

extension WithdrawViewModel: Identifiable {
    var id: String {
        return String(describing: WithdrawViewModel.self)
    }
}

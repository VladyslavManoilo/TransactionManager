//
//  TransactionItemView.swift
//  TransactionManager
//
//  Created by DeveloperMB2020 on 17.06.2024.
//

import SwiftUI

protocol TransactionInfo {
    var merchantName: String { get }
    var amount: String { get }
    var last4: String { get }
    var status: TransactionStatus  { get }
    var tribeTransactionType: TribeTransactionType { get }
}

struct TransactionItemView<T: TransactionInfo>: View {
    let transaction: T
    
    var body: some View {
        ZStack {
            HStack(spacing: 8) {
                ZStack {
                    ZStack(alignment: .bottomTrailing) {
                        Circle()
                            .fill(.neutral50)
                            .frame(width: 40, height: 40)
                        
                        if transaction.status == .failed {
                            Circle()
                                .fill(.failedTransaction)
                                .frame(width: 12, height: 12)
                        }
                    }
                    
                    switch transaction.tribeTransactionType {
                    case .income:
                        Image.appArrowDownLeft
                    case .withdrawal:
                        Image.appCreditCard
                    }
                }
            
                VStack(alignment: .leading, spacing: 0) {
                    Text(transaction.merchantName)
                        .font(.appBody)
                        .foregroundStyle(.neutral800)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    if !transaction.last4.isEmpty {
                        Text("•• \(transaction.last4)")
                            .font(.appCallout)
                            .foregroundStyle(.neutral500)
                    }
                }
                
                Text(transaction.amount)
                    .font(.appBody)
                    .foregroundStyle(transactionAmountForeground)
            }
        }
        .frame(height: 56)
    }

    private var transactionAmountForeground: Color {
        switch transaction.tribeTransactionType {
        case .income:
            return Color.incomeAmount
        case .withdrawal:
            switch transaction.status {
            case .successed, .pending, .cancelled:
                return Color.neutral800
            case .failed:
                return Color.neutral500
            }
        }
    }
}

#Preview {
    VStack {
        TransactionItemView(transaction: Transaction(id: "0", tribeTransactionId: "0", tribeCardId: 1, amount: "-€1500", status: .successed, tribeTransactionType: .withdrawal, schemeId: "", merchantName: "Google", pan: "7575"))
        
        TransactionItemView(transaction: Transaction(id: "0", tribeTransactionId: "0", tribeCardId: 1, amount: "-€500", status: .failed, tribeTransactionType: .withdrawal, schemeId: "", merchantName: "Google", pan: "4141"))
        
        TransactionItemView(transaction: Transaction(id: "0", tribeTransactionId: "0", tribeCardId: 1, amount: "€500", status: .successed, tribeTransactionType: .income, schemeId: "", merchantName: "Load", pan: ""))
    }
}

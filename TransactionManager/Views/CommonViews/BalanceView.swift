//
//  BalanceView.swift
//  TransactionManager
//
//  Created by DeveloperMB2020 on 17.06.2024.
//

import SwiftUI

struct BalanceView: View {
    let logo: String
    let balance: String
    let currency: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack(spacing: 8) {
                Text(logo)
                    .font(.appBody)
                
                Text("\(currency) account")
                    .font(.appBody)
                    .foregroundStyle(.neutral500)
            }
            
            Text(balance)
                .font(.appTitle)
                .foregroundStyle(.neutral900)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    BalanceView(logo: "🇪🇺", balance: "153,000.50", currency: "EUR")
}

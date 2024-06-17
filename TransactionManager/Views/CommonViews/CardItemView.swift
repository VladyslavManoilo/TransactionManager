//
//  CardItemView.swift
//  TransactionManager
//
//  Created by DeveloperMB2020 on 17.06.2024.
//

import SwiftUI

struct CardItemView: View {
    let cardLast4: String
    let cardName: String
    
    var body: some View {
        HStack {
            ZStack(alignment: .bottomTrailing) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(.neutral800)
                
                Text(cardLast4)
                    .font(.appCaption)
                    .foregroundStyle(.neutral0)
                    .padding(6)
            }
            .frame(width: 48, height: 32)
            
            Text(cardName)
                .font(.appBody)
                .foregroundStyle(.neutral900)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(height: 56)
    }
}

#Preview {
    CardItemView(cardLast4: "4141", cardName: "Google")
}

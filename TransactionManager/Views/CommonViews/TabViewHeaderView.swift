//
//  TabViewHeaderView.swift
//  TransactionManager
//
//  Created by DeveloperMB2020 on 17.06.2024.
//

import SwiftUI

struct TabViewHeaderView: View {
    let title: String
    var onPlusButton: VoidClosure?

    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 4) {
                Spacer()
                
                if let onPlusButton = onPlusButton {
                    Button {
                        onPlusButton()
                    } label: {
                        Image.appPlusIcon
                            .frame(width: 44, height: 44)
                            .contentShape(Rectangle())
                    }
                }
            }
            .padding(.horizontal, 16)
            .frame(height: 44)
            
            Text(title)
                .font(.appTitle)
                .foregroundStyle(.neutral800)
                .padding(.horizontal, 16)
                .frame(minHeight: 45)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    TabViewHeaderView(title: "Tab Title")
}

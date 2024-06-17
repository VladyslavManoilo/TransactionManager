//
//  WithdrawView.swift
//  TransactionManager
//
//  Created by DeveloperMB2020 on 17.06.2024.
//

import SwiftUI

struct WithdrawView: View {
    @ObservedObject private var viewModel: WithdrawViewModel

    init(viewModel: WithdrawViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.placeholderBackground
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    headerView
                    
                    ZStack {
                        VStack(spacing: 24) {
                            amountInputView(geometry: geometry)
                            
                            Spacer()
                            
                            Button {
                                viewModel.withdrawalProcessed()
                            } label: {
                                Text("Continue")
                                    .font(.appTitle3)
                                    .foregroundStyle(.neutral0)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 48)
                                    .background(viewModel.isWithdrawAvailable ? .blue500 : .blue200)
                                    .clipShape(Capsule())
                                    .contentShape(Capsule())
                            }
                            .disabled(!viewModel.isWithdrawAvailable)
                        }
                    }
                    .padding(.horizontal, 16)
                    .frame(maxHeight: .infinity)
                }
            }
        }
    }
    
    private var headerView: some View {
        HStack(spacing: 4) {
            Color.clear
                .frame(width: 42, height: 42)
            
            Text("Transfer")
                .font(.appTitle2)
                .foregroundStyle(.neutral800)
                .frame(maxWidth: .infinity)
            
            Button {
                viewModel.withdrawCancelled()
            } label: {
                Image.appCloseIcon
                    .frame(width: 42, height: 42)
                    .contentShape(Rectangle())
            }
        }
        .padding(.top, 12)
        .padding(.horizontal, 16)
    }
    
    private func amountInputView(geometry: GeometryProxy) -> some View {
        let maxWidthForDescription: CGFloat = geometry.size.width * 0.8
        let minWidthForInput: CGFloat = 20
        let maxWidthForInput: CGFloat = max(minWidthForInput, geometry.size.width * 0.7)

        return VStack(spacing: 12) {
            HStack(spacing: 8) {
                Text(viewModel.currency)
                    .font(.appLargeTitle)
                    .foregroundStyle(.neutral900)
                    .fixedSize(horizontal: true, vertical: true)
                
                ZStack(alignment: .leading) {
                    if viewModel.amount == nil {
                        Text("0")
                            .font(.appLargeTitle)
                            .foregroundStyle(.neutral200)
                    }
                    
                    TextField("", text: $viewModel.amountText)
                    .font(.appLargeTitle)
                    .keyboardType(.decimalPad)
                    .frame(minWidth: minWidthForInput, maxWidth: maxWidthForInput)
                    .fixedSize()
                    .onChange(of: viewModel.amountText) { (oldValue, newValue) in
                        viewModel.formateAmount(newValue, oldValue: oldValue)
                    }
                }
            }
            
            ZStack {
                if viewModel.isAmountAvailable {
                    Text("You have ")
                        .font(.appFootnote)
                        .foregroundStyle(.neutral500) +
                    Text(viewModel.balanceString)
                        .font(.appSubhead)
                        .foregroundStyle(.neutral800) +
                    Text("\n available in your balance")
                        .font(.appFootnote)
                        .foregroundStyle(.neutral500)
                } else {
                    Text("You have only \(viewModel.balanceString)\navailable in your balance")
                        .font(.appFootnote)
                        .foregroundStyle(.red500)
                }
            }
            .multilineTextAlignment(.center)
            .frame(maxWidth: maxWidthForDescription)
        }
        .frame(maxHeight: .infinity)
    }
}

#Preview {
    WithdrawView(viewModel: WithdrawViewModel(currency: "€", balance: 153000.12, withdrawCancelled: {}, withdrawFinished: {}))
}

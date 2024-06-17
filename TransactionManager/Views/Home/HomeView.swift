//
//  HomeView.swift
//  TransactionManager
//
//  Created by DeveloperMB2020 on 17.06.2024.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            Color.placeholderBackground
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                titleHeaderView
                
                List {
                    Section {
                        BalanceView(logo: viewModel.accountType.logo,
                                    balance: viewModel.balanceString,
                                    currency: viewModel.accountType.currency)
                    }
                    .clearListSecionStyle()
                    
                    
                    Section {
                        VStack(spacing: 0) {
                            seeAllHeaderView(title: "My cards", onAction: {
                                // TODO: open all cards screen
                            })
                            
                            ForEach(viewModel.paymentCards) { card in
                                CardItemView(cardLast4: card.cardLast4, cardName: card.cardName)
                            }
                        }
                    }
                    .clearListSecionStyle()

                    
                    Section {
                        VStack(spacing: 0) {
                            seeAllHeaderView(title: "Recent transactions", onAction: {
                                // TODO: open all transactions screen
                            })
                            
                            ForEach(viewModel.recentTransactions) { transaction in
                                HStack(spacing: 8) {
                                    TransactionItemView(transaction: transaction)
                                    
                                    ZStack {
                                        if viewModel.transactionHasNoReceipt(transaction) {
                                            Image.appNoReceiptAttachment
                                                .renderingMode(.template)
                                                .foregroundStyle(.red500)
                                        }
                                    }
                                    .frame(width: 20)
                                }
                            }
                        }
                    }
                    .clearListSecionStyle()
                }
                .listSectionSpacing(24)
                .listStyle(.plain)
                .refreshable {
                    viewModel.fetchData()
                }
            }
        }
        .onAppear {
            viewModel.fetchData()
        }
        .sheet(item: $viewModel.withdrawViewModel) { withdrawViewModel in
            WithdrawView(viewModel: withdrawViewModel)
        }
    }
    
    private var titleHeaderView: some View {
        TabViewHeaderView(title: "Money", onPlusButton: {
            viewModel.withdrawRequested()
        })
    }
    
    private func seeAllHeaderView(title: String, onAction: @escaping VoidClosure) -> some View {
        HStack {
            Text(title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.appTitle2)
                .foregroundStyle(.neutral800)
            
            Button {
               onAction()
            } label: {
                Text("See All")
                    .font(.appBody)
                    .foregroundStyle(.blue500)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .frame(minHeight: 40)
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel(apiManager: MockApiManager(teamId: "test-teamid"), accountType: .eu))
}

fileprivate extension View {
    func clearListSecionStyle() -> some View {
        self.listRowInsets(EdgeInsets())
            .listRowBackground(Color.clear)
            .listSectionSeparator(.hidden)
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(RoundedRectangle(cornerRadius: 14).fill(.neutral0))
            .padding(.horizontal, 16)
    }
}

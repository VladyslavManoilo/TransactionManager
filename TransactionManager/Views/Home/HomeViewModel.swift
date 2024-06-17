//
//  HomeViewModel.swift
//  TransactionManager
//
//  Created by DeveloperMB2020 on 17.06.2024.
//

import Foundation

final class HomeViewModel: ObservableObject {
    private let apiManager: any ApiManager
    let accountType: AccountType
    private var fetchTask: Task<Void, Error>?
    private var balance: Double = 0 {
        didSet {
            let currency = accountType.currencySymbol
            balanceString = balance.moneyString(currencySymbol: currency) ?? ""
        }
    }
    
    @Published var balanceString: String = ""
    @Published var paymentCards: [PaymentCard] = []
    @Published var recentTransactions: [Transaction] = []
    @Published var withdrawViewModel: WithdrawViewModel?
    
    init(apiManager: ApiManager, accountType: AccountType) {
        self.apiManager = apiManager
        self.accountType = accountType
    }
    
    func fetchData() {
        fetchTask?.cancel()
        
        fetchTask = Task {
            await fetchBalance()
            
            await fetchCards()
            
            await fetchTransactions()
        }
    }
    
    private func fetchBalance() async {
        let result = await apiManager.fetchBalance()
        switch result {
        case .success(let balanceWrapper):
            await MainActor.run {
                self.balance = balanceWrapper.balance
            }
        case .failure(let error):
            debugPrint(error)
        }
    }
    
    private func fetchCards() async {
        let result = await apiManager.fetchCards()
        switch result {
        case .success(let cards):
            await MainActor.run {
                paymentCards = cards
            }
        case .failure(let error):
            debugPrint(error)
        }
    }
    
    private func fetchTransactions() async {
        let result = await apiManager.fetchTransactions()
        switch result {
        case .success(let transactions):
            await MainActor.run {
                recentTransactions = transactions
            }
        case .failure(let error):
            debugPrint(error)
        }
    }
    
    func transactionHasNoReceipt(_ transaction: Transaction) -> Bool {
        // As far transaction model doesn't have fields that could be possible realted to the reciept attachment use dummy logic there
        return transaction.id == "1"
    }

    func withdrawRequested() {
        withdrawViewModel = WithdrawViewModel(currency: accountType.currencySymbol,
                                              balance: balance,
                                              withdrawCancelled: { [weak self] in
            self?.withdrawCancelled()
        }, withdrawFinished: { [weak self] in
            self?.withdrawFinished()
        })
    }
    
    private func withdrawCancelled() {
        withdrawViewModel = nil
    }

    private func withdrawFinished() {
        fetchData()
        withdrawViewModel = nil
    }
}

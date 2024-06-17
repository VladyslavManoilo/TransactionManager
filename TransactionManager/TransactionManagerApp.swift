//
//  TransactionManagerApp.swift
//  TransactionManager
//
//  Created by DeveloperMB2020 on 17.06.2024.
//

import SwiftUI

@main
struct TransactionManagerApp: App {
    private let teamId = "some-dummy-team-id"
    private let accountType = AccountType.eu
    
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: HomeViewModel(apiManager: MockApiManager(teamId: teamId), accountType: accountType))
        }
    }
}

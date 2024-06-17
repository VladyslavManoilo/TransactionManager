//
//  MockApiManager.swift
//  TransactionManager
//
//  Created by DeveloperMB2020 on 17.06.2024.
//

import Foundation

final class MockApiManager: ApiManager {
    private let baseURL: String = Bundle.main.bundleURL.absoluteString
    private let teamId: String
        
    private enum ClientApi {
        case balance(teamId: String)
        case cards(teamId: String)
        case transactions(teamId: String)
        
        var path: String {
            switch self {
            case .balance:
                return "cards/account/total-balance"
            case .cards:
                return "cards"
            case .transactions:
                return "cards/transactions"
            }
        }
        
        
        var queryItems: [URLQueryItem] {
            switch self {
            case .balance(let teamId):
                return [URLQueryItem(name: "teamId", value: teamId)]
            case .cards(let teamId):
                return [URLQueryItem(name: "teamId", value: teamId)]
            case .transactions(let teamId):
                return [URLQueryItem(name: "teamId", value: teamId)]
            }
        }
        
        var method: String {
            switch self {
            case .balance, .cards, .transactions:
                return "GET"
            }
        }
    }
    
    init(teamId: String) {
        self.teamId = teamId
    }
        
    func fetchBalance() async -> Result<Balance, ApiError> {
        guard let request = urlRequest(for: .balance(teamId: teamId)) else {
            return .failure(.somethingWentWrong)
        }
        
        
        do {
            let data = try data(for: request)
            let balance: Balance = try decode(data)
            return .success(balance)
        } catch {
            return .failure(.somethingWentWrong)
        }
    }
    
    func fetchCards() async -> Result<[PaymentCard], ApiError> {
        guard let request = urlRequest(for: .cards(teamId: teamId)) else {
            return .failure(.somethingWentWrong)
        }
        
        do {
            let data = try data(for: request)
            let cardsWrapper: PaymentCardsWrapper = try decode(data)
            return .success(cardsWrapper.cards)
        } catch {
            return .failure(.somethingWentWrong)
        }
    }
    
    func fetchTransactions() async -> Result<[Transaction], ApiError> {
        guard let request = urlRequest(for: .transactions(teamId: teamId)) else {
            return .failure(.somethingWentWrong)
        }
        
        do {
            let data = try data(for: request)
            let transactions: [Transaction] = try decode(data)
            return .success(transactions)
        } catch {
            return .failure(.somethingWentWrong)
        }
    }
    
    private func urlRequest(for api: ClientApi) -> URLRequest? {
        guard var url = URL(string: baseURL + api.path) else {
            return nil
        }
        url.append(queryItems: api.queryItems)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = api.method
        
        return urlRequest
    }

    private func data(for request: URLRequest) throws -> Data {
        guard let filePath = request.url?.removingQuery(), let fileURL = URL(string: "\(filePath).json") else {
            throw ApiError.somethingWentWrong
        }
        return try Data(contentsOf: fileURL)
    }
    
    private func decode<T: Decodable>(_ data: Data) throws -> T {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        return try decoder.decode(T.self, from: data)
    }
}

fileprivate extension URL {
    func removingQuery() -> URL? {
        guard var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: false) else {
            return nil
        }
        
        urlComponents.query = nil
        return urlComponents.url
    }
}

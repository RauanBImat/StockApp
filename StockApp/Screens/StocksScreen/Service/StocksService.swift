//
//  StocksService.swift
//  StockApp
//
//  Created by Рауан Абишев on 26.05.2022.
//

import Foundation

enum StocksRouter: Router {
    
    //https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&per_page=100
    case stocks(currency: String, count: String)
    
    var baseUrl: String {
        "https://api.coingecko.com"
    }
    
    var path: String {
        switch self {
        case .stocks:
           return "/api/v3/coins/markets"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .stocks:
            return .get
        }
    }
    
    var parameters: Parameters {
        switch self {
        case .stocks(let currency, let count):
            return ["vs_currency" : currency, "per_page" : count]
        }
    }
}

protocol StocksServiceProtocol {
    func getStocks(currency: String, count: String, completion: @escaping(Result<[Stock], NetworkError>) -> Void)
    func getStocks(currency: String, completion: @escaping(Result<[Stock], NetworkError>) -> Void)
    func getStocks(completion: @escaping(Result<[Stock], NetworkError>) -> Void)
}

extension StocksServiceProtocol {
    func getStocks(currency: String, completion: @escaping(Result<[Stock], NetworkError>) -> Void) {
        getStocks(currency: currency, count: "100", completion: completion)
    }
    
    func getStocks(completion: @escaping(Result<[Stock], NetworkError>) -> Void) {
        getStocks(currency: "usd", completion: completion)
    }
    
}

final class StocksService: StocksServiceProtocol {
    
    private let client: NetworkService
    
    init(client: NetworkService) {
        self.client = client
    }
    
    
    func getStocks(currency: String, count: String, completion: @escaping (Result<[Stock], NetworkError>) -> Void) {
        client.execute(with: StocksRouter.stocks(currency: currency, count: count), completion: completion)
    }
    
    
}

//
//  StocksService.swift
//  StockApp
//
//  Created by Рауан Абишев on 26.05.2022.
//

import Foundation

fileprivate enum Constants {
    static let currency = "usd"
    static let count = "80"
}

protocol StocksServiceProtocol {
    func getStocks(currency: String, count: String, completion: @escaping (Result<[StockModelProtocol], NetworkError>) -> Void)
    func getStocks(currency: String, completion: @escaping (Result<[StockModelProtocol], NetworkError>) -> Void)
    func getStocks(completion: @escaping (Result<[StockModelProtocol], NetworkError>) -> Void)
    func getFavoriteStocks() -> [StockModelProtocol]
    func getStocks() -> [StockModelProtocol]
    
}

final class StocksService: StocksServiceProtocol {
    
    private let network: NetworkService
    private var stocksModels: [StockModelProtocol] = []
    
    
    init(network: NetworkService) {
        self.network = network
    }
    
    func getStocks(currency: String, count: String, completion: @escaping (Result<[StockModelProtocol], NetworkError>) -> Void) {
        network.execute(with: StocksRouter.stocks(currency: currency, count: count)) { [weak self] (result: Result<[Stock], NetworkError>) in
            guard let self = self else { return }
            switch result {
            case .success(let stocks):
                completion(.success(self.stockModels(for: stocks)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    private func stockModels(for stocks: [Stock]) -> [StockModelProtocol] {
        stocksModels = stocks.map { StockModel(stock: $0) }
        return stocksModels
    }
    
    func getFavoriteStocks() -> [StockModelProtocol] {
        stocksModels.filter {$0.isFavotite}
    }
    
    func getStocks() -> [StockModelProtocol] {
        stocksModels
    }
    
}

extension StocksServiceProtocol {
    func getStocks(currency: String, completion: @escaping (Result<[StockModelProtocol], NetworkError>) -> Void) {
        getStocks(currency: currency, count: Constants.count, completion: completion)
    }
    
    func getStocks(completion: @escaping (Result<[StockModelProtocol], NetworkError>) -> Void) {
        getStocks(currency: Constants.currency, completion: completion)
    }
}

//
//  SearchService.swift
//  StockApp
//
//  Created by Рауан Абишев on 09.06.2022.
//

import Foundation

protocol SearchServiceProtocol {
    func getFilterStocks(by text: String?) -> [StockModelProtocol]
}


class SearchService: SearchServiceProtocol {
    
    private let service: StocksServiceProtocol
    
    
    init(service: StocksServiceProtocol) {
       self.service = service
   }
    
    
    func getFilterStocks(by text: String?) -> [StockModelProtocol] {
        guard let text = text,
              !text.isEmpty else {
            return service.getStocks()
        }
        return service.getStocks().filter {$0.symbol.lowercased().contains(text.lowercased())}
    }
        
}

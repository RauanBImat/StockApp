//
//  StocksModel.swift
//  StockApp
//
//  Created by Рауан Абишев on 01.06.2022.
//

import Foundation
import UIKit

protocol StockModelProtocol {
    var id: String { get }
    var name: String { get }
    var iconURL: String { get }
    var symbol: String { get }
    var price: String { get }
    var change: String { get }
    var changeColor: UIColor { get }
    
    var isFavotite: Bool { get set }
    
    func setFavorite()
}

final class StockModel: StockModelProtocol {
    private let stock: Stock
    private let favoriteService: FavoritesServiceProtocol
    
    init(stock: Stock) {
        self.stock = stock
        favoriteService = Assembly.assembler.favoritesService
        isFavotite = favoriteService.isFavorite(for: id)
    }
    
    var id: String {
        stock.id
    }
    
    var name: String {
        stock.name
    }
    
    var iconURL: String {
        stock.image
    }
    
    var symbol: String {
        stock.symbol
    }
    var price: String {
        "$" + Double.checkDecimal(check: stock.price)
    }
    
    var change: String {
        if stock.change >= 0.0 {
            return "+" + "$" + Double.checkDecimal(check: stock.change)
            
        } else {
            return "$" + Double.checkDecimal(check: stock.change)
        }
        
    }
    
    var changeColor: UIColor {
        stock.change >= 0 ? .backgroundGreen : .red
    }
    
    var isFavotite: Bool = false
    
    func setFavorite() {
        isFavotite.toggle()
        
        if isFavotite {
            favoriteService.save(id: id)
        } else {
            favoriteService.remove(id: id)
        }
    }
}

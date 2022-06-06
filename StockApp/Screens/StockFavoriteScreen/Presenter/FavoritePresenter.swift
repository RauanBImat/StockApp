//
//  FavoritePresenter.swift
//  StockApp
//
//  Created by Рауан Абишев on 03.06.2022.
//

import Foundation


protocol FavoriteViewProtocol: AnyObject {
    func updateView()
    func updateView(withLoader isLoading: Bool)
    func updateView(withError message: String)
    func updateCell(for indexPath: IndexPath, state: Bool)
}

protocol FavoritePresenterProtocol {
    var view: FavoriteViewProtocol? { get set }
    var itemsCount: Int { get }
    func loadView()
    func model(for indexPath: IndexPath) -> StockModelProtocol
}


final class FavoritePresenter: FavoritePresenterProtocol {
       weak var view: FavoriteViewProtocol?

       private var favoriteStocks: [StockModelProtocol] = []
       private let service: StocksServiceProtocol
       
       
       init(service: StocksServiceProtocol) {
           self.service = service
           startFavoritesNotificationObserving()
       }
       
       var itemsCount: Int {
           favoriteStocks.count
       }
       
       func loadView() {
           favoriteStocks = service.getFavoriteStocks()
           view?.updateView()
       }
       
       func model(for indexPath: IndexPath) -> StockModelProtocol {
           return favoriteStocks[indexPath.row]
       }
}
    
  


extension FavoritePresenter: FavoritesUpdateServiceProtocol {
    func setFavorite(notification: Notification) {
        let prevoisFavorites = favoriteStocks
        favoriteStocks = service.getFavoriteStocks()
        
        guard let id = notification.stockId else { return }
       
        if let index = favoriteStocks.firstIndex(where: { $0.id == id }) {
            view?.updateCell(for: IndexPath(row: index, section: 0), state: true)
        } else if let index = prevoisFavorites.firstIndex(where: { $0.id == id }){
            view?.updateCell(for: IndexPath(row: index, section: 0), state: false)
        }
    }
    
}
    
  


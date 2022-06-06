//
//  StocksPresenter.swift
//  StockApp
//
//  Created by Рауан Абишев on 01.06.2022.
//

import Foundation
import UIKit


protocol StocksViewProtocol: AnyObject {
    func updateView()
    func updateCell(for indexPath: IndexPath)
    func updateView(withLoader isLoading: Bool)
    func updateView(withError message: String)
}

protocol StocksPresenterProtocol {
    var view: StocksViewProtocol? { get set }
    var itemsCount: Int { get }
    
    func loadView()
    func model(for indexPath: IndexPath) -> StockModelProtocol
}

final class StocksPresenter: StocksPresenterProtocol {
    private let service: StocksServiceProtocol
    private var stoks: [StockModelProtocol] = []
    
    var itemsCount: Int {
        stoks.count
    }
    
    init(service: StocksServiceProtocol) {
        self.service = service
        startFavoritesNotificationObserving()
    }
    
    weak var view: StocksViewProtocol?
    
    func loadView() {
        // Идем в сеть и показываем лоадер
        view?.updateView(withLoader: true)
        
        service.getStocks { [weak self] result in
            // Возвращаемся с данными и убираем лоадер
            self?.view?.updateView(withLoader: false)
            
            switch result {
            case .success(let stocks):
                self?.stoks = stocks
                self?.view?.updateView()
            case .failure(let error):
                self?.view?.updateView(withError: error.localizedDescription)
            }
        }
    }
    
    func model(for indexPath: IndexPath) -> StockModelProtocol {
        stoks[indexPath.row]
    }
}

extension StocksPresenter: FavoritesUpdateServiceProtocol {
    func setFavorite(notification: Notification) {
        guard let id = notification.stockId,
              let index = stoks.firstIndex(where: {$0.id == id }) else { return }
        
        view?.updateCell(for: IndexPath(row: index, section: 0))
    }
}



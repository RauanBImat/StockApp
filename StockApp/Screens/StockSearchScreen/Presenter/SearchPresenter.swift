//
//  SearchPresenter.swift
//  StockApp
//
//  Created by Рауан Абишев on 08.06.2022.
//

import Foundation


protocol SearchTextFiledDelegate: AnyObject {
    func textDidChange(to text: String?)
}

protocol SearchStocksPresenterProtocol: SearchTextFiledDelegate {
    var viewController: StocksViewProtocol? { get set }
    var itemCount: Int { get }
    var namesCount: Int { get }
    func loadView()
    func model(for indexPath: IndexPath) -> StockModelProtocol
    func getName(for indexPath: IndexPath) -> String
}

final class SearchPersenter: SearchStocksPresenterProtocol {
    private let searchService:  SearchServiceProtocol
    private var filteredStocks: [StockModelProtocol] = []
    weak var viewController: StocksViewProtocol?
    private var names: [String] = ["BTC","Apple","Etho"]

    init(service: SearchServiceProtocol) {
        self.searchService = service
        startFavoritesNotificationObserving()
    }
    
    var namesCount: Int {
        names.count
    }

    var itemCount: Int {
        filteredStocks.count
    }
    
    func loadView() {
        filteredStocks = searchService.getFilterStocks(by: nil)
        viewController?.updateView()
    }
    
    func model(for indexPath: IndexPath) -> StockModelProtocol {
        filteredStocks[indexPath.row]
    }
    func getName(for indexPath: IndexPath) -> String {
        return names[indexPath.row]
    }
    
}


extension SearchPersenter: FavoritesUpdateServiceProtocol {
    func setFavorite(notification: Notification) {
        guard let id = notification.stockId,
              let index = filteredStocks.firstIndex(where: { $0.id == id }) else {
            return
        }

        viewController?.updateCell(for: IndexPath(row: index, section: 0))
    }
}


extension SearchPersenter: SearchTextFiledDelegate {
    func textDidChange(to text: String?) {
        filteredStocks = searchService.getFilterStocks(by: text)
        viewController?.updateView()
    }
}

    


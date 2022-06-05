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
    var viewController: FavoriteViewProtocol? { get set }
    func loadView()
}


final class FavoritePresenter: FavoritePresenterProtocol {

    weak var viewController: FavoriteViewProtocol?
    
    private let favoriteService = Assembly.assembler.favoritesService
    private var stocks: [StockModelProtocol] = []
    private var previousfavoriteService: [StockModelProtocol] = []
    private let service: StocksServiceProtocol
 
    
    init(service: StocksServiceProtocol) {
        self.service = service
    }
    
 
    
    func loadView() {
        viewController?.updateView(withLoader: true)
        service.getStocks {[weak self] result in
            self?.viewController?.updateView(withLoader: false)
            switch result {
            case .success(let stocks):
                self?.viewController?.updateView()
            case .failure(let error):
                self?.viewController?.updateView(withError: error.localizedDescription)
        }
    }
}
    
  
}
    
  


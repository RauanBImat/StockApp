//
//  StockDetailPresenter.swift
//  StocksApp
//
//  Created by Aimukhambetov Zhassulan on 30.05.2022.
//

import Foundation


protocol StockDetailViewProtocol: AnyObject {
    func updateView()
    func updateView(withLoader isLoading: Bool)
    func updateView(withError message: String)
}

protocol StockDetailPresenterProtocol {
    var titleModel: DetailTitleView.TilteModel { get }
    var favoriteButtonIsSelected: Bool { get }
    var price: String { get }
    var procent: String { get }
    
    func loadView()
    func favoriteButtonTapped()
}

final class StockDetailPresenter: StockDetailPresenterProtocol {
    private let model: StockModelProtocol
    private let service: ChartsServiceProtocol
    var price: String {
        model.price
    }
    var procent: String{
        model.change
    }
    
    weak var view: StockDetailViewProtocol?
    
    lazy var titleModel: DetailTitleView.TilteModel = {
        .from(stockModel: model)
    }()
    
    var favoriteButtonIsSelected: Bool {
        model.isFavotite
    }
    
    init(model: StockModelProtocol, service: ChartsServiceProtocol) {
        self.model = model
        self.service = service
    }
    
    func loadView() {
        view?.updateView(withLoader: true)
        service.getCharts(id: model.id) { [weak self] result in
            self?.view?.updateView(withLoader: false)
            switch result {
            case .success(let charts):
                self?.view?.updateView()
            case .failure(let error):
                self?.view?.updateView(withError: error.localizedDescription)
            }
        }
    }
    
    func favoriteButtonTapped() {
        model.setFavorite()
    }
}

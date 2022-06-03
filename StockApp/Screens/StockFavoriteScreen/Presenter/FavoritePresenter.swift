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
   
}

protocol FavoritePresenterProtocol {
   
    func loadView()
    var view: FavoriteViewProtocol? { get set }
}


final class FavoritePresenter: FavoritePresenterProtocol {
    var view: FavoriteViewProtocol?
    
    func loadView() {
        view?.updateView(withLoader: false)
    }
}
    
  


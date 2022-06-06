//
//  ModuleBuilder.swift
//  StockApp
//
//  Created by Рауан Абишев on 02.06.2022.
//

import Foundation
import UIKit


final class Assembly {
    static let assembler: Assembly = .init()
    let favoritesService: FavoritesServiceProtocol = FavoritesLocalService()

    private init() {}

    private lazy var network: NetworkService = Network()
    
    private lazy var stocksService: StocksServiceProtocol = StocksService(network: network)
    private lazy var chartsService: ChartsServiceProtocol = ChartsService(network: network)
    
    
    private func stocksModule() -> UIViewController {
        let presneter = StocksPresenter(service: stocksService)
        let view = StocksViewController(presenter: presneter)
        presneter.view = view
        
        return view
    }
    
    private func favoriteModule() -> UIViewController {
        let presenter = FavoritePresenter(service: stocksService)
        let favoritesVC = FavoriteViewController(presenter: presenter)
        presenter.view = favoritesVC
        return favoritesVC
    }
    
    
    
    func thirdVC() -> UIViewController {
        UIViewController()
    }
    
    func tabbarController() -> UIViewController {
            let tabbar = UITabBarController()
            
            
            let stocksVC = UINavigationController(rootViewController: stocksModule())
            stocksVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "diagram"), tag: 0)
            
            let favoriteVC = UINavigationController(rootViewController: favoriteModule())
            favoriteVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Icon"), tag: 1)
            
            let thirdVC = thirdVC()
            thirdVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Search") , tag: 2)
            
            tabbar.viewControllers = [stocksVC, favoriteVC, thirdVC]
            tabbar.tabBarItem.imageInsets = .init(top: 5, left: 0, bottom: -5, right: 0)
            tabbar.tabBar.barTintColor = .white
            return tabbar
        }
    
    func detailVC(model: StockModelProtocol) -> UIViewController {
        let presenter = StockDetailPresenter(model: model, service: chartsService)
        let view = StockDetailViewController(presenter: presenter)
        presenter.view = view
        return view
    }
}

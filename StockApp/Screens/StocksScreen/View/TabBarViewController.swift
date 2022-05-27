//
//  ViewController.swift
//  StockApp
//
//  Created by Рауан Абишев on 27.05.2022.
//

import UIKit

class TabBarViewController: UITabBarController{
    
    
  

    override func viewDidLoad() {
            super.viewDidLoad()
            let stocksVC = StocksViewController()
            let searchVC = SearchViewController()
            let favoriteVC = FavoriteViewController()

            let stocksNC = createNavigationController(vc: stocksVC, title: "Stocks", image: UIImage(named: "diagram"))
            let favoriteNC = createNavigationController(vc: favoriteVC, title: "Favorite", image: UIImage(named: "Icon"))
            let searchNC = createNavigationController(vc: searchVC, title: "Search", image: UIImage(named: "Search"))
          

        viewControllers = [stocksNC, favoriteNC,searchNC]
    }

        func createNavigationController(vc: UIViewController, title: String, image: UIImage?) -> UINavigationController {
            vc.navigationItem.title = title
            let navController = UINavigationController(rootViewController: vc)
            let item = UITabBarItem(title: "", image: image, tag: 0)
            item.imageInsets = .init(top: 5, left: 0, bottom: -5, right: 0)
            navController.navigationBar.prefersLargeTitles = true
            tabBar.barTintColor = .white
            
            navController.tabBarItem = item
            return navController
        }
    
   

}

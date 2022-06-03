//
//  FavoriteViewController.swift
//  StockApp
//
//  Created by Рауан Абишев on 03.06.2022.
//

import UIKit

class FavoriteViewController: UIViewController {

    
    private let presenter: FavoritePresenterProtocol
    
    init(presenter: FavoritePresenterProtocol) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        presenter.loadView()

    }
    
    
    


}

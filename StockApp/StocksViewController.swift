//
//  ViewController.swift
//  StockApp
//
//  Created by Рауан Абишев on 24.05.2022.
//

import UIKit

final class StocksViewController: UIViewController {

   private lazy var tableView: UITableView = {
        let tableView = UITableView()
       tableView.translatesAutoresizingMaskIntoConstraints = false
       
       
       tableView.separatorStyle = .none
    
       tableView.register(StockCell.self, forCellReuseIdentifier:StockCell.typeName)
       
       
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        setupSubview()
        
        tableView.dataSource = self
    }
    
    private func setupSubview(){
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }


}

extension StocksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StockCell.typeName, for: indexPath) as! StockCell
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
}

extension NSObject {
    static var typeName: String {
        String(describing: self)
    }
}


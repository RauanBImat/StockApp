//
//  ViewController.swift
//  StockApp
//
//  Created by Рауан Абишев on 24.05.2022.
//

import UIKit

final class StocksViewController: UIViewController{

    private var stocks: [Stock] = []
    
    
    
   private lazy var tableView: UITableView = {
        let tableView = UITableView()
       tableView.translatesAutoresizingMaskIntoConstraints = false
       
       
       tableView.separatorStyle = .none
    
       tableView.register(StockCell.self, forCellReuseIdentifier:StockCell.typeName)
       
    
        return tableView
    }()
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
      
        view.backgroundColor = .white
        setupSubview()
        
        
        tableView.dataSource = self
        tableView.delegate = self
        
        getStocks()
        

    
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
    private func getStocks() {
            let client = Network()
            let service: StocksServiceProtocol = StocksService(client: client)
            
            service.getStocks { result in
                switch result {
                case .success(let stocks):
                    self.stocks = stocks
                    self.tableView.reloadData()
                case .failure(let error):
                    self.showError(error.localizedDescription)
                }
            }
        }
        
        func showError(_ message: String) {
            
        }
    }
        

extension StocksViewController: UITableViewDataSource ,UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StockCell.typeName, for: indexPath) as! StockCell
        cell.setBackgroundColor(for: indexPath.row)
        cell.configure(with: stocks[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            guard let cell = tableView.cellForRow(at: indexPath) as? StockCell else{ return }
            let detailStockVC = DetailsStockViewController()
            detailStockVC.configure(with: stocks[indexPath.row])
            navigationController?.pushViewController(detailStockVC, animated: true)
        }

   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }
       
    
}

extension NSObject {
    static var typeName: String {
        String(describing: self)
    }
}


struct Stock:Decodable {
    
    let id: String
    let symbol: String
    let name: String
    let image: String
    let price: Double
    let change: Double
    let changePercentage: Double

    
    enum CodingKeys: String, CodingKey {
        case id,symbol,name,image
        case price = "current_price"
        case change = "price_change_24h"
        case changePercentage = "price_change_percentage_24h"
    }
    
}

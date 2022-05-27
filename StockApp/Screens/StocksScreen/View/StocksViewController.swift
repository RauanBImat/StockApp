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
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        setupSubview()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        getStock()
    
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
    private func getStock() {
        
        let session = URLSession(configuration: .default)
        let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&per_page=100"
        guard let url = URL(string: urlString) else { return }
        let task = session.dataTask(with: url, completionHandler: {[weak self] data,response,error in
            if let error = error {
                print("Error - " , error.localizedDescription)
            }
            guard let response = response as? HTTPURLResponse else {
                return

            }
            print("Status code - ", response.statusCode)
            
            guard let data = data else {
                return
            }
            print("Data",data)
            
            
           
            
            guard let json = try? JSONDecoder().decode([Stock].self, from: data) else {
                return
            }
            DispatchQueue.main.async {
                self?.stocks = json
                self?.tableView.reloadData()
            }
        })
        
        
        
        task.resume()
        
        
        
        
        
        
    }
    


}

extension StocksViewController: UITableViewDataSource ,UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StockCell.typeName, for: indexPath) as! StockCell
        cell.setBackgroundColor(for: indexPath.row)
        cell.configure(with: stocks[indexPath.row])
        return cell
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

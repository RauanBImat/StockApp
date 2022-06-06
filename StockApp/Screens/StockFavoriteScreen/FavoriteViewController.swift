//
//  FavoriteViewController.swift
//  StockApp
//
//  Created by Рауан Абишев on 03.06.2022.
//

import UIKit

final class FavoriteViewController: UIViewController {

    
    private let presenter: FavoritePresenterProtocol
    
    init(presenter: FavoritePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    private lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemBackground
        tableView.register(StockCell.self, forCellReuseIdentifier: StockCell.typeName)
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        
       return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVeiw()
        setupSubview()
        presenter.loadView()
    }
    
    private func setupVeiw() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    private func setupSubview() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func showError(_ message: String) {
        
    }
}


extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.itemsCount
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StockCell.typeName, for: indexPath) as? StockCell else { return UITableViewCell() }
        cell.setBackgroundColor(for: indexPath.row)
        cell.configure(with: presenter.model(for: indexPath))
        return cell
    }
}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? StockCell else{ return }
        cell.viewAnimate()
        
        let currentModel = presenter.model(for: indexPath)
        let detailStockVC = Assembly.assembler.detailVC(model: currentModel)
        navigationController?.pushViewController(detailStockVC, animated: true)
    }
}

extension FavoriteViewController: FavoriteViewProtocol {
  
    
    func updateView() {
        tableView.reloadData()
    }
    
    func updateView(withLoader isLoading: Bool) {
        
    }
    
    func updateView(withError message: String) {
        
    }
    
    func updateCell(for indexPath: IndexPath, state: Bool) {
        state
        ? tableView.insertRows(at: [indexPath], with: .automatic)
        : tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    
    

}

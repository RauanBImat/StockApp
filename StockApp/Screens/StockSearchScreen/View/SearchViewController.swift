//
//  SearchViewController.swift
//  StockApp
//
//  Created by Рауан Абишев on 08.06.2022.
//

import UIKit

final class SearchViewController: UIViewController {
    private let presenter: SearchStocksPresenterProtocol
    
    init(presenter: SearchStocksPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var searchView: SearhView = {
        let view = SearhView()
        view.delegate = presenter
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
//    private lazy var collectionView: UICollectionView = {
//        let collectionView = UICollectionView()
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.backgroundColor = .systemBackground
//        collectionView.register(RequestSearch.self, forCellWithReuseIdentifier: "RequestSearch")
//        collectionView.dataSource = self
//        collectionView.delegate = self
//        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
//        collectionView.frame = .zero
//        return collectionView
//
//    }()//Ща новом коммите делаю популярные запросы  и недавние запросы Серч
    
    
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
        setupView()
        setupSubview()
        presenter.loadView()
        setupGestures()
    }

    
    private func setupView() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    
    private func setupSubview() {
        
        view.addSubview(searchView)
        view.addSubview(tableView)
        
        
        NSLayoutConstraint.activate([
            searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 8),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupGestures() {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.forcedHidingKeyboard))
            self.view.addGestureRecognizer(tapGesture)
    }
    
    private func showError(_ message: String) {
        // show error
    }
    
    @objc private func forcedHidingKeyboard() {
            self.view.endEditing(true)
    }
    
}


extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.itemCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StockCell.typeName, for: indexPath) as? StockCell else { return UITableViewCell() }
        cell.setBackgroundColor(for: indexPath.row)
        cell.configure(with: presenter.model(for: indexPath))
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? StockCell else{ return }
        cell.viewAnimate()
        
        let currentModel = presenter.model(for: indexPath)
        let detailStockVC = Assembly.assembler.detailVC(model: currentModel)
        navigationController?.pushViewController(detailStockVC, animated: true)
    }
    
    
}

extension SearchViewController: StocksViewProtocol {
    
    func updateView() {
        tableView.reloadData()
    }
    
    func updateView(withLoader isLoading: Bool) {
        // show or hide loader
    }
    
    func updateView(withError message: String) {
        // show error message
    }
    
    func updateCell(for indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
}

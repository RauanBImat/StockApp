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
        view.searchTextField.addTarget(self, action: #selector(editingBegan(_:)), for: .editingDidBegin)
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout  = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(RequestSearch.self, forCellWithReuseIdentifier: RequestSearch.typeName)
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    private lazy var collectionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "You’ve searched for this"
        label.font = .bold(size: 18)
        return label
    }()
    
    
    
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemBackground
        tableView.register(StockCell.self, forCellReuseIdentifier: StockCell.typeName)
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isHidden = true
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
        view.addSubview(collectionView)
        view.addSubview(collectionLabel)
       
        
        NSLayoutConstraint.activate([
            searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 8),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionLabel.topAnchor.constraint(equalTo: searchView.bottomAnchor,constant: 39),
            collectionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            collectionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16),
            collectionView.topAnchor.constraint(equalTo: collectionLabel.bottomAnchor,constant: 15),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
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
        self.searchView.infoStackView.isHidden = true
        self.collectionView.isHidden = false
        self.collectionLabel.isHidden = false
        self.tableView.isHidden = true
        self.view.endEditing(true)
    }
    
    @objc func editingBegan(_ textField: UITextField) {
        collectionView.isHidden = true
        collectionLabel.isHidden = true
        tableView.isHidden = false
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

extension SearchViewController: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.namesCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RequestSearch", for: indexPath) as! RequestSearch
        cell.textLabel.text = presenter.getName(for: indexPath)
        return cell
    }
}

extension SearchViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row + 1)
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

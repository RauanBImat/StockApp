//
//  DetailsViewController.swift
//  StockApp
//
//  Created by Рауан Абишев on 27.05.2022.
//



import UIKit

class DetailsStockViewController: UIViewController {
    private lazy var companyLabel: UILabel = {
        let label = UILabel()
        label.font = .bold(size: 18)
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .semiBold(size: 12)
        return label
    }()
    
    private lazy var StackViews: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [companyLabel, titleLabel])
        stackView.translatesAutoresizingMaskIntoConstraints  = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var backBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(backButtonTapped))
        return button
    }()
    
    private lazy var starButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(starButtonTapped))
        return button
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .bold(size: 28)
        return label
    }()
    
    private lazy var procentLabel: UILabel = {
        let label = UILabel()
        label.font = .semiBold(size: 12)
        label.textColor = UIColor.backgroundGreen
        return label
    }()
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        setupNavigationBar()
        setupViews()
        setupConstraints()
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.tabBarController?.tabBar.isHidden = false
    }
    private lazy var priceStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [priceLabel, procentLabel])
        stackView.translatesAutoresizingMaskIntoConstraints  = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }()
    
    // MARK: - Methods
    func configure(with stock: Stock) {
        companyLabel.text = stock.symbol.uppercased()
        titleLabel.text = stock.name
        priceLabel.text = "\(stock.price)"
        
        if stock.change >= 0.0 {
            procentLabel.text = "+" + Double.checkDecimal(check: stock.change)
            procentLabel.textColor = .backgroundGreen
            } else {
            procentLabel.text = Double.checkDecimal(check: stock.change)
            procentLabel.textColor = .red
            }
    }
    
    private func setupNavigationBar() {
        navigationController?.tabBarController?.tabBar.isHidden = true
        self.navigationItem.titleView = StackViews
        navigationController?.navigationBar.tintColor = .black
        navigationItem.setLeftBarButton(backBarButton, animated: false)
        navigationItem.setRightBarButton(starButton, animated: false)
    }
    private func setupViews() {
        view.addSubview(priceStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            priceStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            priceStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 63)
        ])
    }
    
    // MARK: - Selectors
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func starButtonTapped() {
        // change rightBarButtonItem Color
    }
}


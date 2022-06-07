//
//  StockDetailViewController.swift
//  StocksApp
//
//

import UIKit

final class StockDetailViewController: UIViewController {
    private lazy var titleView: UIView = {
        let view = DetailTitleView()
        view.configure(with: presenter.titleModel)
        return view
    }()
    
    private lazy var chartsContainerView: ChartsContainerView = {
        let view = ChartsContainerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let presenter: StockDetailPresenterProtocol
    
    override var hidesBottomBarWhenPushed: Bool {
        get { true }
        set { super.hidesBottomBarWhenPushed = newValue }
    }
    
    init(presenter: StockDetailPresenterProtocol) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupNavigationBar()
        setupFavoriteButton()
        setupConstraints()
        presenter.loadView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(priceStackView)
        view.addSubview(chartsContainerView)
        view.addSubview(buyButton)
        
        NSLayoutConstraint.activate([
            chartsContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chartsContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            chartsContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 150),
            buyButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -20),
            buyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
            buyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16),
            buyButton.heightAnchor.constraint(equalToConstant: 56),
            buyButton.widthAnchor.constraint(equalToConstant: 328)
        ])
    }
    
    private func setupNavigationBar() {
        navigationItem.titleView = titleView
        let backButton =  UIBarButtonItem(image: UIImage(named: "back"),
                                          style: .plain,
                                          target: self,
                                          action: #selector(backBattonTapped))
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
    }
    
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
    
    private lazy var buyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Buy for", for: .normal)
        button.titleLabel?.font = .semiBold(size: 16)
        button.backgroundColor = .black
        button.layer.cornerRadius = 16
        button.layer.cornerCurve = .continuous
        button.addTarget(self, action: #selector(buybutton), for: .touchUpInside)
        return button
    }()
    
    private lazy var priceStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [priceLabel, procentLabel])
        stackView.translatesAutoresizingMaskIntoConstraints  = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }()
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            priceStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            priceStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 63)
        ])
    }
    
    private func setupFavoriteButton() {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "Star"), for: .normal)
        button.setImage(UIImage(named: "Path2"), for: .selected)
        button.isSelected = presenter.favoriteButtonIsSelected
        button.frame = CGRect(x: 0, y: 0, width: 22, height: 22)
        button.addTarget(self, action: #selector(favoriteTapped(_:)), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }

    
    @objc
    private func favoriteTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        presenter.favoriteButtonTapped()
    }
    
    @objc
    private func buybutton(_ sender: UIButton){
        let aletController = UIAlertController(title: "Thanks!🥳", message: "Purchase successful🎉🎉", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        
        aletController.addAction(action)
        self.present(aletController, animated: true,completion: nil)
    }
    
    @objc
    private func backBattonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

extension StockDetailViewController: StockDetailViewProtocol {
    func updateView(withLoader isLoading: Bool) {
        chartsContainerView.configure(with: isLoading)
    }
    
    func updateView(withError message: String) {
        
    }
    
    func updateView() {
        chartsContainerView.configure(with: ChartsModel())
        priceLabel.text = presenter.price
        procentLabel.text = presenter.procent
        buyButton.setTitle("Buy for " + presenter.price, for: .normal)
    }
}

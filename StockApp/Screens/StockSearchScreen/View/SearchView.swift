//
//  SearchView.swift
//  StockApp
//
//  Created by Рауан Абишев on 09.06.2022.
//

import Foundation
import UIKit


final class SearhView: UIStackView {
    weak var delegate: SearchTextFiledDelegate?

    
    public lazy var searchTextField: UITextField = {
        let searchTextField = UITextField()
        searchTextField.delegate = self
        searchTextField.placeholder = "Find Company or ticker"
        searchTextField.font = UIFont.semiBold(size: 16)
        searchTextField.tintColor = .black
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        searchTextField.returnKeyType = .go
        searchTextField.autocorrectionType = .no
        searchTextField.autocapitalizationType = .none
        searchTextField.addTarget(self, action: #selector(editingBegan(_:)), for: .editingDidBegin)
        return searchTextField
    }()
    
    private lazy var searchButton: UIButton  = {
        let button = UIButton()
        button.setImage(UIImage(named: "Ellipse"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var clearButton: UIButton  = {
        let button = UIButton()
        button.setImage(UIImage(named: "clearButton"), for: .normal)
        button.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var showMoreButton: UIButton  = {
        let button = UIButton()
        button.setTitle("Show more", for: .normal)
        button.titleLabel?.font = UIFont.bold(size: 12)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(showMoreButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var itemsView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1.5
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Stocks"
        label.font = UIFont.bold(size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    public lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel,showMoreButton])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    private func setupViews() {
        axis = .vertical
        spacing = 30
        alignment = .fill
        distribution = .fill
        
        itemsView.addSubview(searchButton)
        itemsView.addSubview(searchTextField)
        itemsView.addSubview(clearButton)
        
        addArrangedSubview(itemsView)
        addArrangedSubview(infoStackView)
        infoStackView.isHidden = true
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            
            itemsView.heightAnchor.constraint(equalToConstant: 45),
            
            searchButton.leadingAnchor.constraint(equalTo: itemsView.leadingAnchor, constant: 16),
            searchButton.centerYAnchor.constraint(equalTo: itemsView.centerYAnchor),
            searchButton.heightAnchor.constraint(equalToConstant: 16),
            searchButton.widthAnchor.constraint(equalToConstant: 15),
            
            clearButton.trailingAnchor.constraint(equalTo: itemsView.trailingAnchor, constant: -16),
            clearButton.centerYAnchor.constraint(equalTo: itemsView.centerYAnchor),
            clearButton.heightAnchor.constraint(equalToConstant: 16),
            clearButton.widthAnchor.constraint(equalToConstant: 16),
            
            
            searchTextField.leadingAnchor.constraint(equalTo: searchButton.trailingAnchor, constant: 10),
            searchTextField.trailingAnchor.constraint(equalTo: clearButton.leadingAnchor, constant: -10),
            searchTextField.centerYAnchor.constraint(equalTo: itemsView.centerYAnchor),
        ])
    }
    
    @objc func editingBegan(_ textField: UITextField) {
        infoStackView.isHidden = false
    }
    
    @objc private func clearButtonTapped() {
        searchTextField.text = ""
        textDidChange(sender: searchTextField)
    }
    
    @objc private func showMoreButtonTapped() {
        endEditing(true)
    }
    
    
    @objc private func textDidChange(sender: UITextField) {
        delegate?.textDidChange(to: sender.text)
    }
    

    
}
    
extension SearhView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

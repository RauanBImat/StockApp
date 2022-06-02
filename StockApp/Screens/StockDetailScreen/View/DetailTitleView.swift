//
//  DetailTitleView.swift
//  StocksApp
//
//  Created by Aimukhambetov Zhassulan on 30.05.2022.
//

import UIKit

final class DetailTitleView: UIView {
    struct TilteModel {
        let symbol: String
        let name: String
        
        static func from(stockModel model: StockModelProtocol) -> TilteModel {
            TilteModel(symbol: model.symbol, name: model.name)
        }
    }
    
    private lazy var symbolLabel: UILabel = {
        let label = UILabel()
        label.font = .bold(size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .semiBold(size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
   
    
   
    
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: TilteModel) {
        symbolLabel.text = model.symbol.uppercased()
        nameLabel.text = model.name
        
    }
    
    private func setupSubviews() {
        addSubview(symbolLabel)
        addSubview(nameLabel)
        symbolLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor).isActive = true
        symbolLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor).isActive = true
        symbolLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        symbolLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        nameLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: symbolLabel.bottomAnchor).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        
       
     
      
        
    }
}

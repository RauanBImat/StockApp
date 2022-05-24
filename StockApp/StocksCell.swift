//
//  StocksCell.swift
//  StockApp
//
//  Created by Рауан Абишев on 24.05.2022.
//

import UIKit

final class StockCell: UITableViewCell {
    private lazy var iconView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        
        image.backgroundColor = .red
        image.layer.cornerRadius = 12
        image.clipsToBounds = true 
        image.image = UIImage(named: "YNDX")
        
        return image
    }()
    
    private lazy var symbolLabel: UILabel = {
        let label = UILabel()
        label.text = "YNDX"
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false

        
        
        return label
    }()
    
//    private lazy var companyLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Yandex, LLC"
//        label.font = .systemFont(ofSize: 12)
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        return label
//    }()
    
//    private lazy var priceLabel: UILabel = {
//        let label = UILabel()
//        label.text = "4 764,6 ₽"
//        label.font = .systemFont(ofSize: 18)
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        return label
//    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(iconView)
        contentView.addSubview(symbolLabel)
//        contentView.addSubview(companyLabel)
//        contentView.addSubview(priceLabel)


        
        
        setupConstraints()
    }
    
    private  func setupConstraints(){
        NSLayoutConstraint.activate([
            iconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 8),
            iconView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 8),
            iconView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -8),
            iconView.heightAnchor.constraint(equalToConstant: 52),
            iconView.widthAnchor.constraint(equalToConstant: 52),
            
            
            symbolLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor,constant: 12),
            symbolLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 14)
            
//            companyLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor,constant: 12),
//            companyLabel.topAnchor.constraint(equalTo: symbolLabel.bottomAnchor),
//
//            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -17),
//            priceLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 14)
        
        ])
    }
}

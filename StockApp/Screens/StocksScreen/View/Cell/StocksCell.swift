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
        label.font = UIFont.bold(size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false

        
        
        return label
    }()
    

    
    private lazy var star: UIButton = {
       let image = UIButton()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        
        image.setImage(UIImage(named: "Path.png"), for: .normal)

        
        return image
    }()
    
    private lazy var companyLabel: UILabel = {
        let label = UILabel()
        label.text = "Yandex, LLC"
        label.font = UIFont.semiBold(size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "4 764,6 ₽"
        label.font = UIFont.semiBold(size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    private lazy var procentLabel: UILabel = {
        let label = UILabel()
        label.text = "+55 ₽ (1,15%)"
        label.textColor = UIColor.backgroundGreen
        label.font = UIFont.semiBold(size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var elementsView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
        }()
    
    
    func setBackgroundColor(for row: Int) {
        elementsView.backgroundColor = row % 2 == 0
        ? UIColor.backgroundGray
      : UIColor.white
        
    }

 
    


  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        setupViews()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(with stock: Stock){
        
        symbolLabel.text = stock.symbol.uppercased()
        companyLabel.text = stock.name
        priceLabel.text = Double.checkDecimal(check: stock.price)
        
        if stock.change >= 0.0 {
            procentLabel.text = "+" + Double.checkDecimal(check: stock.change)
            procentLabel.textColor = .backgroundGreen
            } else {
            procentLabel.text = Double.checkDecimal(check: stock.change)
            procentLabel.textColor = .red
            }
            
    }
    
    
    private func setupViews() {
        selectionStyle = .none
        contentView.addSubview(elementsView)
        elementsView.addSubview(iconView)
        elementsView.addSubview(symbolLabel)
        elementsView.addSubview(companyLabel)
        elementsView.addSubview(priceLabel)
        elementsView.addSubview(procentLabel)
        elementsView.addSubview(star)

        



        
        
        setupConstraints()
    }
    
    private  func setupConstraints(){
        
        
        NSLayoutConstraint.activate([
            iconView.leadingAnchor.constraint(equalTo: elementsView.leadingAnchor,constant: 8),
            iconView.topAnchor.constraint(equalTo: elementsView.topAnchor,constant: 8),
            iconView.bottomAnchor.constraint(equalTo: elementsView.bottomAnchor,constant: -8),
            iconView.heightAnchor.constraint(equalToConstant: 52),
            iconView.widthAnchor.constraint(equalToConstant: 52),
            
            
            symbolLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor,constant: 12),
            symbolLabel.topAnchor.constraint(equalTo: elementsView.topAnchor,constant: 14),
            
            companyLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor,constant: 12),
            companyLabel.topAnchor.constraint(equalTo: symbolLabel.bottomAnchor),

            priceLabel.trailingAnchor.constraint(equalTo: elementsView.trailingAnchor,constant: -17),
            priceLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 14),
            
            procentLabel.trailingAnchor.constraint(equalTo: elementsView.trailingAnchor,constant: -12),
            procentLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor),
            
            star.leadingAnchor.constraint(equalTo: symbolLabel.trailingAnchor,constant: 6),
            star.topAnchor.constraint(equalTo: elementsView.topAnchor,constant: 17),
            star.heightAnchor.constraint(equalToConstant: 16),
            star.widthAnchor.constraint(equalToConstant: 16),
            
            elementsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            elementsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            elementsView.topAnchor.constraint(equalTo: contentView.topAnchor),
            elementsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
            
          
            
        
        ])
    }
}

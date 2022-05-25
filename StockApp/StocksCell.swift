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
        label.font = UIFont.Bold(size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false

        
        
        return label
    }()
    
    private lazy var  backgroundCell: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        label.font = UIFont.SemiBold(size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "4 764,6 ₽"
        label.font = UIFont.SemiBold(size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    private lazy var procentLabel: UILabel = {
        let label = UILabel()
        label.text = "+55 ₽ (1,15%)"
        label.textColor = UIColor(red: 36 / 255,
                                  green: 178 / 255,
                                  blue: 93 / 255,
                                  alpha: 1)
        label.font = UIFont.SemiBold(size: 12)
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
        ? UIColor(red: 240 / 255,
                  green: 244 / 255,
                  blue: 247 / 255,
                  alpha: 1)
      : UIColor.white
        
       elementsView.layer.cornerRadius = 16
    }

    

//
//    override func layoutSubviews() {
//            super.layoutSubviews()
//            //set the values for top,left,bottom,right margins
//        contentView.frame = frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0))
//        }
  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        setupViews()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(elementsView)
        elementsView.addSubview(iconView)
        elementsView.addSubview(symbolLabel)
        elementsView.addSubview(companyLabel)
        elementsView.addSubview(priceLabel)
        elementsView.addSubview(procentLabel)
        elementsView.addSubview(backgroundCell)
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

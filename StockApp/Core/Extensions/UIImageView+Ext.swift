//
//  UIImageView+Ext.swift
//  StockApp
//
//  Created by Рауан Абишев on 08.06.2022.
//


import Kingfisher
import UIKit

extension UIImageView {
    func setImage(from source: String?, placeHolder: UIImage?) {
        guard let urlString = source, let url = URL(string: urlString) else { return }
        
        kf.setImage(with: .network(url), placeholder: placeHolder)
    }
}

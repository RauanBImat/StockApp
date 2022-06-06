//
//  UIColor.swift
//  StockApp
//
//  Created by Рауан Абишев on 26.05.2022.
//

import Foundation
import UIKit

extension UIColor{
    static let backgroundGray = UIColor(red: 240 / 255,
                       green: 244 / 255,
                       blue: 247 / 255,
                       alpha: 1)
    
    static let backgroundGreen = UIColor(red: 36 / 255,
                                green: 178 / 255,
                                blue: 93 / 255,
                                alpha: 1)
    
    static var selectionColor: UIColor {
        .gray.withAlphaComponent(0.3)
    }
    static var buttonColor =  UIColor(red:248/255,green: 244/255,blue: 247/255,alpha: 1)

}

//
//  UIFont.swift
//  StockApp
//
//  Created by Рауан Абишев on 25.05.2022.
//

import Foundation
import UIKit

extension UIFont {
    
    static func Regular(size: CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-Regular", size: size)!
    }
    
    static func Bold(size: CGFloat) -> UIFont {
            return UIFont(name: "Montserrat-Bold", size: size)!
        }
    
    static func Medium(size: CGFloat) -> UIFont {
            return UIFont(name: "Montserrat-Medium", size: size)!
        }
    static func SemiBold(size: CGFloat) -> UIFont {
            return UIFont(name: "Montserrat-SemiBold", size: size)!
        }
}

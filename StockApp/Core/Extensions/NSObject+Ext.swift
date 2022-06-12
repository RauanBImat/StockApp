//
//  NSObject+Ext.swift
//  StockApp
//
//  Created by Рауан Абишев on 02.06.2022.
//

import Foundation

extension NSObject {
    static var typeName: String {
        String(describing: self)
    }
}

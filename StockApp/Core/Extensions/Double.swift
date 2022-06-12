//
//  Double.swift
//  StockApp
//
//  Created by Рауан Абишев on 27.05.2022.
//

import Foundation

extension Double {
    
    private func rounded(digits: Int) -> Double {
           let multiplier = pow(10.0, Double(digits))
           return (self * multiplier).rounded() / multiplier
       }

       private func truncate(places : Int)-> Double {
           return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
       }
    
    static func checkDecimal(check: Double?) -> String {
        let res: String
        guard let value = check else { return "" }
        if value.truncatingRemainder(dividingBy: 1) == 0 {
            res = "\(Int(value))"
        } else {
            res = "\(ceil(value * 10000) / 10000)"
        }
        return res
    }
}

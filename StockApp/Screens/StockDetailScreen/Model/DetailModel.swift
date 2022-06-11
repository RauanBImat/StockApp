//
//  StockModel.swift
//  StockApp
//
//  Created by Рауан Абишев on 09.06.2022.
//

import Foundation


struct DetailModel {
    struct Period {
        let name: String
        let prices: [Double]
    }
    
    let periods: [Period]
    
    static func build(from response: Charts) -> DetailModel {
        let lastDateIndex = response.prices.count - 1
        let weekPeriod = oneWeekPeriod()
        let monthPeriod = oneMonthPeriod()
        let sixMonth = SixMonthPeriod()
        let oneYear = OneYearPeriod()
        
        func oneWeekPeriod() -> Period {
            let firstIndex = response.prices.count - 7
            let prices = Array( response.prices[firstIndex...lastDateIndex])
                .map{ roundPrice(price: $0.price) }
            return Period(name: "W", prices: prices)
        }
        
        func oneMonthPeriod() -> Period {
            let firstIndex = response.prices.count - 30
            let prices = Array( response.prices[firstIndex...lastDateIndex])
                .map{ roundPrice(price: $0.price) }
            return Period(name: "M", prices: prices)
        }
        
        
        func SixMonthPeriod() -> Period {
            let firstIndex = response.prices.count - 180
            let prices = Array( response.prices[firstIndex...lastDateIndex])
                .map{ roundPrice(price: $0.price) }
            return Period(name: "6M", prices: prices)
        }
        
        func OneYearPeriod() -> Period {
            let prices = response.prices.map{ roundPrice(price: $0.price) }
            return Period(name: "1Y", prices: prices)
        }
        
        func roundPrice(price: Double) -> Double {
            Double(round(price * 100) / 100)
        }
        
        
        
        return DetailModel(periods: [weekPeriod, monthPeriod, sixMonth, oneYear])
    }
}

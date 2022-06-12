//
//  FavoriteService.swift
//  StockApp
//
//  Created by Рауан Абишев on 02.06.2022.
//

import Foundation

protocol FavoritesServiceProtocol {
    func save(id: String)
    func remove(id: String)
    func isFavorite(for id: String) -> Bool
}

//
//  UserDefaultsFavoritesService.swift
//  StockApp
//
//  Created by Рауан Абишев on 02.06.2022.
//

import Foundation

final class FavoritesService: FavoritesServiceProtocol {
    private let key = "favorite_key"
    private lazy var favoriteIds: [String] = {
        guard let data = UserDefaults.standard.object(forKey: key) as? Data,
              let ids = try? JSONDecoder().decode([String].self, from: data) else {
            return []
        }
        
        return ids
    }()
    
    func save(id: String) {
        favoriteIds.append(id)
        updateRepo()
    }
    
    func remove(id: String) {
        if let index = favoriteIds.firstIndex(where: { $0 == id }) {
            favoriteIds.remove(at: index)
            updateRepo()
        }
    }
    
    func isFavorite(for id: String) -> Bool {
        favoriteIds.contains(id)
    }
    
    private func updateRepo() {
        guard let data = try? JSONEncoder().encode(favoriteIds) else {
            return
        }
        
        UserDefaults.standard.set(data, forKey: key)
        print("UserDefaults update")
    }
}


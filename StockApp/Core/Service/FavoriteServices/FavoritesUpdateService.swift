//
//  FavoritesUpdateService.swift
//  StockApp
//
//  Created by Рауан Абишев on 02.06.2022.
//

import Foundation


@objc protocol FavoritesUpdateServiceProtocol {
    func setFavorite(notification: Notification)
}

extension FavoritesUpdateServiceProtocol {
    func startFavoritesNotificationObserving() {
        NotificationCenter.default.addObserver(self, selector: #selector(setFavorite), name: NSNotification.Name.favorites, object: nil)
    }
}

extension NSNotification.Name {
    static let favorites = NSNotification.Name("Update.Favorite.Stocks")
}

extension Notification {
    var stockId: String? {
        guard let userInfo = userInfo,
                let id = userInfo["id"] as? String else {
            return nil
        }

        return id
    }
}

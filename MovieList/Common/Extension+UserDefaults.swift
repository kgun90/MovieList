//
//  Extension+UserDefaults.swift
//  MovieList
//
//  Created by Geon Kang on 2021/10/27.
//

import Foundation

enum Initial {
    case yes, no
}

extension UserDefaults {
    static let key = "items"
    static var items: [MovieResponseItem]? {
        get {
            guard let data = standard.object(forKey: key) as? Data else { return nil }
            let decoder = JSONDecoder()
            return try? decoder.decode([MovieResponseItem].self, from: data)
        }
        set {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(newValue) {
                standard.set(encoded, forKey: key)
            }
        }
    }
}

struct Favorite {
    static func checkItem(link: String) -> Bool {
        let items = UserDefaults.items
        let result = items?.contains(where: { item in
            item.link == link
        })
        return result ?? false
    }
    
    static func storeItem(item: MovieResponseItem) {
        var items = UserDefaults.items
        items?.append(item)
        UserDefaults.items = items
    }
    
    static func removeItem(item: MovieResponseItem) {
        let items = UserDefaults.items
        
        UserDefaults.items = items?.filter{ $0.link != item.link }
    
    }
    
}

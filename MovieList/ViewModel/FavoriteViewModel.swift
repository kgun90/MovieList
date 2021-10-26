//
//  FavoriteViewModel.swift
//  MovieList
//
//  Created by Geon Kang on 2021/10/27.
//

import Foundation

struct FavoriteViewModel {
    let favoriteData = Observable([MovieResponseItem]())
        
    func getFavoriteData() {
        guard let items = UserDefaults.items else { return }
        favoriteData.value = items
    }
}

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
        favoriteData.value = UserDefaults.items!
    }
}

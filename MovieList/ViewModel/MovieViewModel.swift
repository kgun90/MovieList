//
//  MovieViewModel.swift
//  MovieList
//
//  Created by 강건 on 2021/10/26.
//

import Foundation

struct MovieViewModel {
    let movieData = Observable([MovieResponseItem]())
    let itemTotal = Observable(0)
    var keyword = ""
    
    func setUserDefaults() {
        if UserDefaults.items == nil {
            UserDefaults.items = [MovieResponseItem]()
        }
    }

    func requestMovieAPI(count: Int, from start: Int = 1) {
        MovieAPIService.fetchAPI(keyword: keyword, count: count, start: start) { res in
            switch res {
            case is MovieResponse:
                let model = res as! MovieResponse
               
                if let items = model.items {
                    movieData.value += items
                }            
                itemTotal.value = model.total ?? 0
                
                print("Movie API Request success: \(model.display)")
                
            case is FailResponse:
                let fail = res as! FailResponse
                print("Movie API Request Fail: \(fail.errorMessage)")
                
            default:
                print("Movie API Request Network Failure")
            }
        }
    }
}

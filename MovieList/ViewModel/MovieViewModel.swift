//
//  MovieViewModel.swift
//  MovieList
//
//  Created by 강건 on 2021/10/26.
//

import Foundation

struct MovieViewModel {
    let movieData = Observable([MovieResponseItem]())
    var keyword = ""
    
    func requestMovieAPI() {
        MovieAPIService.fetchAPI(keyword: self.keyword) { res in
            switch res {
            case is MovieResponse:
                let model = res as! MovieResponse
                if let items = model.items {
                    movieData.value = items
                }
               
                
                print("Movie API Request Success: \(model.lastBuildDate)")
                
            case is FailResponse:
                let fail = res as! FailResponse
                print("Movie API Request Fail: \(fail.message)")
                
            default:
                print("Movie API Request Network Failure")
            }
        }
    }
}

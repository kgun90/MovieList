//
//  MovieAPIService.swift
//  MovieList
//
//  Created by 강건 on 2021/10/26.
//

import Foundation

struct MovieAPIService {
    static func fetchAPI(keyword: String, count: Int, completion: @escaping(Response?) -> Void) {
        let query = [
            "query" : keyword,
            "display" : String(count)
        ]
        
        API.request(query: query, type: MovieResponse.self) { res in
            completion(res)
        }
    }
}

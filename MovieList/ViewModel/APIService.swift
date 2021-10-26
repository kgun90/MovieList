//
//  APIService.swift
//  MovieList
//
//  Created by 강건 on 2021/10/26.
//

import Foundation

struct APIService {
    static func fetchAPI(keyword: String, completion: @escaping(Response?) -> Void) {
        let query = [ "query" : keyword ]
        API.request(query: query, type: MovieResponse.self) { res in
            completion(res)
        }
    }
}

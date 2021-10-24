//
//  Constant+API.swift
//  MovieList
//
//  Created by Geon Kang on 2021/10/23.
//

import Foundation
import Alamofire


struct API {
    let baseURL = "https://openapi.naver.com/v1/search/movie.json"
    let headers: HTTPHeaders = [
        "Content-Type" : "application/json",
        "accept" : "application/json",
        "X-Naver-Client-Id" : "CLQgKmnn0zf0E_s9catA",
        "X-Naver-Client-Secret" : "D5cTKA7xKa"
    ]
    
//    static func request<R: Response> ()
}

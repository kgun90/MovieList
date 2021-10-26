//
//  Constant+API.swift
//  MovieList
//
//  Created by Geon Kang on 2021/10/23.
//

import Foundation
import Alamofire

protocol Response: Codable { }

struct FailResponse: Response {
    var code: Int
    var message: String
    var method: String
    var url: String
}

struct API {
    static let baseURL = "https://openapi.naver.com"
    static let headers: HTTPHeaders = [
        "Content-Type" : "application/json",
        "accept" : "application/json",
        "X-Naver-Client-Id" : "CLQgKmnn0zf0E_s9catA",
        "X-Naver-Client-Secret" : "D5cTKA7xKa"
    ]
    
    static func paramToQueryItems(params: [String: String]) -> [URLQueryItem] {
        return params.map {
            URLQueryItem(name: $0.0, value: $0.1)
        }
    }
    static private let successRange = 200 ..< 300
    static private let failRange = 400 ..< 500
    
    public enum result {
        case success
        case fail
    }
    
    static func checkRange(range: Int) -> result {
        if successRange.contains(range) {
            return .success
        } else if failRange.contains(range) {
            return .fail
        } else {
            return .fail
        }
    }
    
    static func request<R: Response> (query: [String: String]? = nil, type: R.Type, completion: @escaping (Response?) -> Void) {
        var requestURL = URLComponents(string: API.baseURL)!
        
        let queryItem = API.paramToQueryItems(params: query ?? [:])
        requestURL.path = "/v1/search/movie.json"
        requestURL.queryItems = queryItem
        
        AF.request(requestURL, method: .get, headers: headers)
            .responseJSON { response in
                parsingJson(response: response, type: type) { json in
                    completion(json)
                }
        }
    }
    
    static func parsingJson<R: Response> (response: AFDataResponse<Any>, type: R.Type, completion: @escaping (Response?) -> Void) {
        switch response.result {
        case .success(let res):
            let range = response.response?.statusCode ?? 400
       
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: res, options: .prettyPrinted)
                let isSuccess = checkRange(range: range)
                var json: Response? = nil
          
                switch isSuccess {
                case .success:
                    json = try JSONDecoder().decode(type, from: jsonData)
                case .fail:
                    json = try JSONDecoder().decode(FailResponse.self, from: jsonData)
                }
                completion(json)
                
            } catch(let e) {
                print("Service Parsing Error After Success Response \(e.localizedDescription)")
                completion(nil)
            }
            
        case .failure(let e):
            print("Serivce Connection Error After Fail Response\(e.localizedDescription)")
            completion(nil)
            return
        }
    }
}

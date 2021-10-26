//
//  MovieResponse.swift
//  MovieList
//
//  Created by Geon Kang on 2021/10/25.
//

import Foundation

// MARK: - MovieResponse
struct MovieResponse: Response {
    var lastBuildDate: String?
    var total, start, display: Int?
    var items: [MovieResponseItem]?
}

// MARK: - Item
struct MovieResponseItem: Codable {
    var title: String?
    var link: String?
    var image: String?
    var subtitle, pubDate, director, actor: String?
    var userRating: String?
}

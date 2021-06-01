//
//  Movie.swift
//  Movie App
//
//  Created by Ibrahim Mushtaha on 01/06/2021.
//

import Foundation

class Movie : Codable {
    var results: [Content]
       var page: Int
    var total_pages: Int
    var total_results: Int
}

class Content: Codable {
    var adult: Bool
    var backdrop_path: String
    var id: Int
    var original_language: String
    var original_title: String
    var overview: String
    var popularity: String
    var poster_path: String
    var release_date: String
    var title: String
    var video: String
    var vote_average: String
    var vote_count: String
    var genre_ids: [Int]
    
}

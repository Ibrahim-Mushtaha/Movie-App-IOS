//
//  Movie.swift
//  Movie App
//
//  Created by Ibrahim Mushtaha on 01/06/2021.
//

import Foundation

struct MovieResponse: Codable {
    var page: Int
    var total_results: Int
    var total_pages: Int
    var results: [Movie]
}

public class Movie: Codable, Identifiable {
    public var popularity: Float
    public var vote_count: Int
    public var video: Bool
    public var poster_path: String
    public var id: Int
    public var adult: Bool
    public var backdrop_path: String
    public var original_language: String
    public var original_title: String
    public var genre_ids: [Int]
    public var title: String
    public var vote_average: Float
    public var overview: String
    public var release_date: String

    enum CodingKeys: String, CodingKey {
        case popularity = "popularity"
        case vote_count = "vote_count"
        case video = "video"
        case poster_path = "poster_path"
        case id = "id"
        case adult = "adult"
        case backdrop_path = "backdrop_path"
        case original_language = "original_language"
        case original_title = "original_title"
        case genre_ids = "genre_ids"
        case title = "title"
        case vote_average = "vote_average"
        case overview = "overview"
        case release_date = "release_date"
    }

    public init(popularity: Float, vote_count: Int, video: Bool, poster_path: String, id: Int, adult: Bool, backdrop_path: String, original_language: String, original_title: String, genre_ids: [Int], title: String, vote_average: Float, overview: String, release_date: String) {
        self.popularity = popularity
        self.vote_count = vote_count
        self.video = video
        self.poster_path = poster_path
        self.id = id
        self.adult = adult
        self.backdrop_path = backdrop_path
        self.original_language = original_language
        self.original_title = original_title
        self.genre_ids = genre_ids
        self.title = title
        self.vote_average = vote_average
        self.overview = overview
        self.release_date = release_date
    }

    public init() {
        self.popularity = 0.0
        self.vote_count = 0
        self.video = false
        self.poster_path = ""
        self.id = 0
        self.adult = false
        self.backdrop_path = ""
        self.original_language = ""
        self.original_title = ""
        self.genre_ids = []
        self.title = ""
        self.vote_average = 0.0
        self.overview = ""
        self.release_date = ""
    }
}

public typealias MovieResults = [Movie]

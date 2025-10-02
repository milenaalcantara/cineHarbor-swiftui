//
//  Trending.swift
//  CineHarborSwiftUI
//
//  Created by Milena Alcântara on 01/10/25.
//

struct TrendingResponse: Codable {
    let results: [TrendingItem]
}

struct TrendingItem: Codable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let voteAverage: Double
    var isFavorite: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
    }
}

//
//  PopularMovieEntity.swift
//  SOPTving
//
//  Created by 김민재 on 2023/05/11.
//

import UIKit

struct PopularMovieEntity: Decodable {
    let page: Int
    let results: [Result]
    let totalPages: Int
    let totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Result: Decodable {
    let adult: Bool
    let backdropPath: String
    let genreIDS: [Int]
    let id: Int
    let originalLanguage: OriginalLanguage
    let originalTitle, overview: String
    let popularity: Double
    let posterPath: String
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

enum OriginalLanguage: String, Decodable {
    case en = "en"
    case fr = "fr"
}

// MARK: Entity -> Model

extension PopularMovieEntity {
    func toDomain() -> [Movie] {
        return self.results.map {
            let url = TMDBImageURL.posterURL + $0.posterPath
            return Movie(title: $0.title, posterImagePath: url)
        }
    }
}

//
//  Movies.swift
//  moreLikeThis
//
//  Created by Julio Padron on 11/11/23.
//

import Foundation

struct MoviesResponse : Decodable{
    let results: [Movies]
}

struct Movies: Decodable {
    var title: String
    var overview: String
    let backdrop_path: String
    let poster_path: String
    let vote_average: Float
    let vote_count: Int
    let popularity: Double
    
    var backdropImageURL: URL?{
        let baseURL = "https://image.tmdb.org/t/p/w500"
        return URL(string: baseURL + backdrop_path)
    }
    
    var posterImageURL: URL?{
        let baseURL = "https://image.tmdb.org/t/p/original"
        return URL(string: baseURL + poster_path)
    }
}

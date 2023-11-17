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
    var id: Int
    let backdrop_path: String?
    let poster_path: String?
    let vote_average: Float
    let vote_count: Int
    let popularity: Double
    
    
    var backdropImageURL: URL? {
            guard let path = backdrop_path else { return nil }
            let baseURL = "https://image.tmdb.org/t/p/w500"
            return URL(string: baseURL + path)
        }
        
        var posterImageURL: URL? {
            guard let path = poster_path else { return nil }
            let baseURL = "https://image.tmdb.org/t/p/original"
            return URL(string: baseURL + path)
        }
    
}

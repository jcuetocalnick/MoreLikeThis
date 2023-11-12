//
//  TvShow.swift
//  moreLikeThis
//
//  Created by Jane Calnick on 11/12/23.
//

import Foundation
struct TvShowResponse : Decodable{
    let results: [TvShow]
}

struct TvShow: Decodable {
    var name: String
    var overview: String
//    let backdrop_path: String
    let poster_path: String
    let vote_average: Float
    let vote_count: Int
    let popularity: Double
    
//    var backdropImageURL: URL?{
//        let baseURL = "https://image.tmdb.org/t/p/original"
//        //"https://image.tmdb.org/t/p/w500"
//        return URL(string: baseURL + backdrop_path)
//    }
    
    var posterImageURL: URL?{
        let baseURL = "https://image.tmdb.org/t/p/w500"
        //"https://image.tmdb.org/t/p/w500"
        return URL(string: baseURL + poster_path)
    }
}

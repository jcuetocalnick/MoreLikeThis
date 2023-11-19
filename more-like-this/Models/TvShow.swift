//
//  TvShow.swift
//  moreLikeThis
//
//  Created by Janet Cueto Calnick on 11/12/23.
//

import Foundation
struct TvShowResponse : Decodable{
    let results: [TvShow]
}

struct TvShow: Decodable {
    var name: String
    var overview: String
    var id: Int
    let poster_path: String?
    let vote_average: Float
    let vote_count: Int
    let popularity: Double
    
    var posterImageURL: URL?{
        guard let path = poster_path else { return nil }
        let baseURL = "https://image.tmdb.org/t/p/w500"
        //"https://image.tmdb.org/t/p/w500"
        return URL(string: baseURL + path)
    }
}

//
//  Book.swift
//  moreLikeThis
//
//  Created by Miguel Gomez on 11/5/23.
//

import Foundation

struct BooksResponse: Decodable {
    let status: String
    let results: BooksData
    let num_results: Int
}

struct BooksData: Decodable {
    let lists: [List]?
    let books: [Book]?
}

struct List: Decodable {
    let books: [Book]
    let list_name_encoded: String
}

struct Book: Decodable {
    let title: String
    let author: String
    let book_image: URL
    let description: String
    let rank: Int
    let rank_last_week: Int
    let weeks_on_list: Int
}

struct BookDisplayItem {
    let book: Book
    let listNameEncoded: String
}



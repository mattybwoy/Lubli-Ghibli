//
//  FilmData.swift
//  Lubli Ghibli
//
//  Created by Matthew Lock on 01/10/2021.
//

import Foundation

struct Film: Decodable {
    let id: String
    let title: String
    let release_date: String
    let image: String
    let description: String
    let director: String
    let runtime: Int
    let imdb_link: String
}

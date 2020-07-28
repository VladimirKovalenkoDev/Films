//
//  FilmData.swift
//  Films
//
//  Created by Владимир Коваленко on 28.07.2020.
//  Copyright © 2020 Vladimir Kovalenko. All rights reserved.
//

import Foundation

struct DataResults : Codable{
    let results : [FilmResults]
}
struct FilmResults: Codable {
    let title : String
    let overview: String
    let vote_average: Double
    let release_date: String
    let poster_path: String
}

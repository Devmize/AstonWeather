//
//  Evening.swift
//  AstonWeather
//
//  Created by Евгений Мизюк on 26.02.2024.
//

import Foundation

struct Evening: Decodable {
    let tempAVG: Int
    let condition: String
    
    private enum CodingKeys: String, CodingKey {
        case tempAVG = "temp_avg"
        case condition
    }
}

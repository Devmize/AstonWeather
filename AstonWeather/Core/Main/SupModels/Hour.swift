//
//  Hour.swift
//  AstonWeather
//
//  Created by Евгений Мизюк on 25.02.2024.
//

import Foundation

struct Hour: Decodable {
    let hour: String
    let hourTS: Int
    let temp: Int
    let feelsLike: Int
    let condition: String
    
    private enum CodingKeys: String, CodingKey {
        case hour
        case hourTS = "hour_ts"
        case temp
        case feelsLike = "feels_like"
        case condition
    }
}

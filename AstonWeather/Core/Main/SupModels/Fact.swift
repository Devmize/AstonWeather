//
//  Fact.swift
//  AstonWeather
//
//  Created by Евгений Мизюк on 22.02.2024.
//

import Foundation

struct Fact: Decodable {
    let temp: Int
    let feelsLike: Int
    let condition: String
    let obsTime: Int
    
    private enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case condition
        case obsTime = "obs_time"
    }
}

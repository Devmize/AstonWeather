//
//  Forecast.swift
//  AstonWeather
//
//  Created by Евгений Мизюк on 22.02.2024.
//

import Foundation

struct Forecast: Decodable {
    let date: String
    let dateTS: Int
    let parts: Parts
    let hours: [Hour]
    
    private enum CodingKeys: String, CodingKey {
        case date
        case dateTS = "date_ts"
        case parts
        case hours
    }
}

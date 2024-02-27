//
//  CityModel.swift
//  AstonWeather
//
//  Created by Евгений Мизюк on 22.02.2024.
//

import Foundation

struct CityModel: Decodable {
    let now: Int
    let nowDate: String
    let info: Info
    let fact: Fact
    let forecasts: [Forecast]
    
    var conditionString: String {
        switch fact.condition {
        case "clear":
            return "Ясно"
        case "partly-cloudy":
            return "Малооблачно"
        case "cloudy":
            return "Облачно с прояснениями"
        case "overcast":
            return "Пасмурно"
        case "light-rain":
            return "Небольшой дождь"
        case "rain":
            return "Дождь"
        case "heavy-rain":
            return "Сильный дождь"
        case "showers":
            return "Ливень"
        case "wet-snow":
            return "Дождь со снегом"
        case "light-snow":
            return "Небольшой снег"
        case "snow":
            return "Снег"
        case "snow-showers":
            return "Снегопад"
        case "hail":
            return "Град"
        case "thunderstorm":
            return "Гроза"
        case "thunderstorm-with-rain":
            return "Дождь с грозой"
        case "thunderstorm-with-hail":
            return "Гроза с градом"
        default:
            return "Неизвестно"
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case now
        case nowDate = "now_dt"
        case info
        case fact
        case forecasts
    }
}

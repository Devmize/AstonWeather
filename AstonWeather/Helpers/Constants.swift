//
//  Constants.swift
//  AstonWeather
//
//  Created by Евгений Мизюк on 25.02.2024.
//

import Foundation
import UIKit

enum Constants {
    // Offsets for app
    static let lowOffset = 16
    static let offset = 32
    static let mediumOffset = 64
    static let bigOffset = 128
    
    // Offsets for headerView
    static let headerOffset = 10
    static let mediumHeaderOffset = 20
    static let largeHeaderOffset = 30
    
    // Offsets for cells
    static let cellOffset = 5
    
    // Helpers for cells
    static let countOfDaysForWeather = 7
    static let supportCells = 3
    
    // Sizes for font
    static let regularFontSize: CGFloat = 20
    static let mediumFontSize: CGFloat = 30
    static let largeFontSize: CGFloat = 40
    
    // Helpers for networkService
    static let defaultCityName = "Москва"
    static let keyForDefaultCity = "city"
    static let degreesString = "°"
}

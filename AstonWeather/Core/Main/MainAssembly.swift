//
//  MainAssembly.swift
//  AstonWeather
//
//  Created by Евгений Мизюк on 22.02.2024.
//

import Foundation
import UIKit

final class MainAssembly {
    
    func assemble() -> UIViewController {
        let service = NetworkService()
        let viewModel = MainViewModel(networkService: service)
        return MainViewController(viewModel: viewModel)
    }
}

//
//  MainViewModel.swift
//  AstonWeather
//
//  Created by Евгений Мизюк on 22.02.2024.
//

import Foundation
import RxSwift
import RxRelay

// MARK: - Protocols

protocol IMainViewModel {
    var relay: PublishRelay<CityModel> { get }
    func fetchWeather(city: String)
    func getCityModel() -> CityModel?
}

final class MainViewModel: IMainViewModel {
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    private let networkService: INetworkService
    private var cityModel: CityModel?
    
    var relay = PublishRelay<CityModel>()
    
    // MARK: - Lifecycle
    
    init(networkService: INetworkService) {
        self.networkService = networkService
        self.networkService.relay.subscribe { [weak self] event in
            guard let cityModel = event.element else { return }
            self?.cityModel = cityModel
            self?.relay.accept(cityModel)
        }.disposed(by: self.disposeBag)
        self.fetchWeather()
    }
    
    // MARK: - Methods
    
    func fetchWeather(city: String = UserDefaults.standard.string(forKey: Constants.keyForDefaultCity)
                    ?? Constants.defaultCityName) {
        UserDefaults.standard.setValue(city, forKey: Constants.keyForDefaultCity)
        self.networkService.getWeather(city: city)
    }
    
    func getCityModel() -> CityModel? {
        return self.cityModel
    }
}

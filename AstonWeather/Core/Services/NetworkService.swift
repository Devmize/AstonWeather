//
//  NetworkService.swift
//  AstonWeather
//
//  Created by Евгений Мизюк on 12.02.2024.
//

import Foundation
import CoreLocation
import RxSwift
import RxRelay

// MARK: - Enums

private enum Endpoint: String {
    case forecast = "/forecast?"
}

// MARK: - Protocols

protocol INetworkService {
    var relay: PublishRelay<CityModel> { get }
    func getWeather(city: String)
}

final class NetworkService: INetworkService {
    
    // MARK: - Properties
    
    private let apiKey: String = "a3158874-e643-421e-8baa-b348e202a767"
    private let apiKeyName: String = "X-Yandex-API-Key"
    private let apiURL: String = "https://api.weather.yandex.ru/v2"
    
    var relay = PublishRelay<CityModel>()
    
    // MARK: - Methods
    
    func getWeather(city: String) {
        self.getCityCoordinates(city: city) { [weak self] coordinate, error in
            guard error == nil, let coordinate else { return }
            self?.makeRequest(type: .forecast, 
                              lat: coordinate.latitude, lon: coordinate.longitude) { [weak self] data in
                do {
                    let cityModel = try JSONDecoder().decode(CityModel.self, from: data)
                    self?.relay.accept(cityModel)
                    
                } catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print("error: ", error)
                }
            }
        }
    }
    
    private func makeRequest(type: Endpoint, lat: Double, lon: Double, completion: @escaping (_ data: Data) -> Void) {
        guard let url = URL(string: self.apiURL + type.rawValue + "lat=\(lat)" + "&lon=\(lon)") else { return }
        
        var request = URLRequest(url: url)
        request.setValue(self.apiKey, forHTTPHeaderField: self.apiKeyName)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil, let data else { return }
            
            completion(data)
        }.resume()
    }
    
    private func getCityCoordinates(city: String, completion: @escaping (_ coordinate: CLLocationCoordinate2D?,
                                                                        _ error: Error?) -> ()) {
        CLGeocoder().geocodeAddressString(city) { placemarks, error in
            guard let location = placemarks?.first?.location else { return }
            completion(location.coordinate, error)
        }
    }
}

//
//  HeaderView.swift
//  AstonWeather
//
//  Created by Евгений Мизюк on 25.02.2024.
//

import UIKit
import SnapKit

final class HeaderView: UIView {
    
    // MARK: - Properties
    
    lazy var changeCityButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "globe"), for: .normal)
        return button
    }()
    
    private lazy var cityNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Constants.mediumFontSize)
        return label
    }()
    
    private lazy var degressLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Constants.largeFontSize)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Constants.regularFontSize)
        return label
    }()
    
    private lazy var feelsLikeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Constants.regularFontSize)
        return label
    }()
    
    // MARK: - Lifecycle

    init() {
        super.init(frame: .zero)
        
        self.addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func configure(city: CityModel) {
        self.cityNameLabel.text = UserDefaults.standard.string(forKey: Constants.keyForDefaultCity) ?? Constants.defaultCityName
        self.degressLabel.text = "\(city.fact.temp)\(Constants.degreesString)"
        self.descriptionLabel.text = city.conditionString
        self.feelsLikeLabel.text = "Ощущается: \(city.fact.feelsLike)\(Constants.degreesString)"
    }

    private func addSubviews() {
        self.addSubview(self.changeCityButton)
        self.addSubview(self.cityNameLabel)
        self.addSubview(self.degressLabel)
        self.addSubview(self.descriptionLabel)
        self.addSubview(self.feelsLikeLabel)
        
        self.changeCityButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.largeHeaderOffset)
            make.trailing.equalToSuperview().offset(-Constants.largeHeaderOffset)
        }
        
        self.feelsLikeLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-Constants.largeHeaderOffset)
            make.centerX.equalToSuperview()
        }
        
        self.descriptionLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self.feelsLikeLabel.snp.top).offset(-Constants.headerOffset)
            make.centerX.equalTo(self.feelsLikeLabel.snp.centerX)
        }
        
        self.degressLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self.descriptionLabel.snp.top).offset(-Constants.headerOffset)
            make.centerX.equalTo(self.feelsLikeLabel.snp.centerX)
        }
        
        self.cityNameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self.degressLabel.snp.top).offset(-Constants.headerOffset)
            make.centerX.equalTo(self.feelsLikeLabel.snp.centerX)
        }
    }

}

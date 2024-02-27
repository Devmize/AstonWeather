//
//  MainViewController.swift
//  AstonWeather
//
//  Created by Евгений Мизюк on 12.02.2024.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay

final class MainViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel: IMainViewModel
    private let disposeBag = DisposeBag()
    
    private let headerView = HeaderView()
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        self.headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 256)
        tableView.tableHeaderView = self.headerView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.indentifier)
        tableView.register(MainCollectionViewCell.self, forCellReuseIdentifier: MainCollectionViewCell.identifier)
        return tableView
    }()
    
    // MARK: Lifecycle
    
    init(viewModel: IMainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addSubviews()
        self.bind()
    }
    
    // MARK: - Methods

    private func bind() {
        self.viewModel.relay.subscribe { cityModel in
            DispatchQueue.main.async {
                self.headerView.configure(city: cityModel)
                self.tableView.reloadData()
            }
        }.disposed(by: self.disposeBag)
        
        self.headerView.changeCityButton.rx.tap.subscribe { _ in
            let alert = UIAlertController(title: "Введите название города", message: nil, preferredStyle: .alert)
            alert.addTextField { textField in
                textField.placeholder = "Город"
            }
            let actionOK = UIAlertAction(title: "OK", style: .default) { action in
                guard let text = alert.textFields?[0].text, text != "" else { return }
                self.viewModel.fetchWeather(city: text)
            }
            let actionCancel = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(actionCancel)
            alert.addAction(actionOK)
            self.present(alert, animated: true)
        }.disposed(by: self.disposeBag)
    }
    
    private func addSubviews() {
        self.view.addSubview(self.tableView)
        
        self.tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - Extensions

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.countOfDaysForWeather + Constants.supportCells // 1 cell for array of temps and 2 cells for spaces beetwen
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0, 2:
            return 25
        case 1:
            return 100
        default:
            return 75
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cityModel = self.viewModel.getCityModel() else { return UITableViewCell() }
        switch indexPath.row {
        case 0, 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: MainCollectionViewCell.identifier, for: indexPath) as! MainCollectionViewCell
            cell.configure(hours: cityModel.forecasts[0].hours)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.indentifier, for: indexPath) as! MainTableViewCell
            cell.configure(forecast: cityModel.forecasts[indexPath.row - Constants.supportCells])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

//
//  Example3ViewController+TableView.swift
//  Week6
//
//  Created by 서동운 on 8/23/23.
//

import UIKit

extension Example3ViewController {
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        
        tableView.register(WeatherTableViewTextCell.self, forCellReuseIdentifier: WeatherTableViewTextCell.identifier)
        tableView.register(WeatherTableViewImageCell.self, forCellReuseIdentifier: WeatherTableViewImageCell.identifier)
    }
}

extension Example3ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0...2, 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewTextCell.identifier, for: indexPath) as? WeatherTableViewTextCell else { return UITableViewCell() }
            
            cell.update(data: weatherData.contents[indexPath.row])
            
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewImageCell.identifier, for: indexPath) as? WeatherTableViewImageCell else { return UITableViewCell() }
            
            cell.update(data: weatherData.contents[indexPath.row])
            
            return cell
        default:
            return UITableViewCell()
        }
    }
}

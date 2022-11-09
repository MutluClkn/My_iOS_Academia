//
//  MainViewController.swift
//  SehirTanitimKitabi
//
//  Created by Mutlu Çalkan on 20.04.2022.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let APICaller = CityAPI.getCities()
    
    private let tableView : UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func navigationBar() {
        navigationItem.title = "Şehir Tanıtım Kitabı"
       // self.navigationController?.navigationBar.barTintColor = .darkText
       // self.navigationController?.navigationBar.backgroundColor = .systemGray6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return APICaller.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell else { return UITableViewCell() }
        if let city = APICaller[indexPath.row].city {
            cell.label.text = city
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        DispatchQueue.main.async {
            let vc = DetailsViewController()
            vc.cityName.text = self.APICaller[indexPath.row].city
            vc.regionName.text = self.APICaller[indexPath.row].region
            vc.imageView.image = self.APICaller[indexPath.row].image
            self.navigationController?.pushViewController(vc, animated: true)
            self.navigationController?.navigationBar.tintColor = .darkText
        }
    }

}

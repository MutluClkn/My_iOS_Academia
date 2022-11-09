//
//  DetailsViewController.swift
//  SehirTanitimKitabi
//
//  Created by Mutlu Çalkan on 20.04.2022.
//

import UIKit

class DetailsViewController: UIViewController {
    
    let imageView : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        return image
    }()
    
    let cityName : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 28, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    let regionName : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        view.addSubview(imageView)
        view.addSubview(cityName)
        view.addSubview(regionName)
        
        applyConstraints()
    }
    
    func applyConstraints() {
        let imageViewConstraints = [
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: view.frame.height / 1.5)
        ]
        
        let cityNameConstraints = [
            cityName.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50),
            cityName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cityName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ]
        
        let regionNameConstraints = [
            regionName.topAnchor.constraint(equalTo: cityName.bottomAnchor, constant: 10),
            regionName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            regionName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ]
        
        
        NSLayoutConstraint.activate(imageViewConstraints)
        NSLayoutConstraint.activate(cityNameConstraints)
        NSLayoutConstraint.activate(regionNameConstraints)
    }

}

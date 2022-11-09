//
//  CityAPI.swift
//  SehirTanitimKitabi
//
//  Created by Mutlu Çalkan on 20.04.2022.
//

import Foundation
import UIKit

class CityAPI {
    
    static func getCities() -> [Cities]{
        let list = [
            //0 - istanbul
            Cities.init(city: "İstanbul", region: "Marmara", image: UIImage(named: "istanbul")!),
            //1 - ankara
            Cities.init(city: "Ankara", region: "İç Anadolu", image: UIImage(named: "ankara")!),
            //2 - izmir
            Cities.init(city: "İzmir", region: "Ege", image: UIImage(named: "izmir")!),
            //3 - antalya
            Cities.init(city: "Antalya", region: "Akdeniz", image: UIImage(named: "antalya")!),
            //4 - samsun
            Cities.init(city: "Samsun", region: "Karadeniz", image: UIImage(named: "samsun")!),
            //5 - diyarbakir
            Cities.init(city: "Diyarbakır", region: "Doğu Anadolu", image: UIImage(named: "diyarbakir")!),
            //6 - hatay
            Cities.init(city: "Hatay", region: "Güneydoğu Anadolu", image: UIImage(named: "hatay")!),
        ]
        
        return list
    }
    
}

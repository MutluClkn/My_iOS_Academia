//
//  Cities.swift
//  SehirTanitimKitabi
//
//  Created by Mutlu Çalkan on 20.04.2022.
//

import Foundation
import UIKit

class Cities {
    let city : String?
    let region : String?
    let image : UIImage?
    
    init(city : String, region : String, image : UIImage){
        self.city = city
        self.region = region
        self.image = image
    }
}

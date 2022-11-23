//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Mutlu Çalkan on 23.11.2022.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel {
    let bitcoinRate : Double
    let currency : String
    
    var bitcoinRateString : String{
        return String(format: "%.2f", bitcoinRate)
    }
}

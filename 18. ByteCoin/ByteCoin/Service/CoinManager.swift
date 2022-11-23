//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

// MARK: - Coin Manager Delegate Protocol
protocol CoinManagerDelegate{
    func didUpdateCoinValue(_ coinManager : CoinManager, coinModel: CoinModel)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "97C3651D-782D-44A6-B5B8-361C7B817D38"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    var coinManagerDelegate : CoinManagerDelegate?
    
    // MARK: - Get Coin Price
    func getCoinPrice(for currency: String){
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error?.localizedDescription ?? "An error occured while giving a task to the session.")
                    return
                }
                if let data{
                    if let bitcoinPrice = self.parseJSON(coinData: data, currency: currency){
                        self.coinManagerDelegate?.didUpdateCoinValue(self, coinModel: bitcoinPrice)
                    }
                }
            }
            task.resume()
        }
    }
    
    // MARK: - Parse JSON
    func parseJSON(coinData: Data, currency: String) -> CoinModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            let rate = decodedData.rate
            let lastPrice = CoinModel(bitcoinRate: rate, currency: currency)
            return lastPrice
        }catch{
            print(coinManagerDelegate?.didFailWithError(error: error) as Any)
            return nil
        }
    }
}

//
//  MarketController.swift
//  CryptoApp
//
//  Created by Wellington Bezerra on 6/19/19.
//  Copyright © 2019 Felipe Viberti. All rights reserved.
//
import Alamofire

protocol MarketControllerOutput: class {
    
    func success(coins: [Coin])
    func error()
}

final class MarketController {
    
    private var coins: [Coin] = []
    weak var output: MarketControllerOutput?
    
    func fetchCoins() {
        
             NotificationCenter.default.addObserver(self, selector: #selector(MarketController.fetchrealCoins), name: NSNotification.Name(rawValue: "didCompleteGetCoins"), object: nil)
    }
    
    func getCoins() -> [Coin] {
        
        return coins
    }
    
    @objc public func fetchrealCoins() {

        var coinArray:[Coin]! = []
        
        for (key,array) in coins_json as! [String:Any] {
            
            if(key == "data") {
                
                for value in array as! NSArray {
                    let newValue = value as! [String:Any]
                    let name = newValue["name"] as! String
                    let initials = newValue["symbol"] as! String
                    let quote = newValue["quote"] as! [String:Any]
                    let usdPrices = quote["USD"] as! [String:Any]
                    let price = usdPrices["price"] as! Double
                    let change = usdPrices["percent_change_1h"] as! Double
                    coinArray.append(Coin(name: name, initials: initials, imageView: "", value: String(price), percentage: String(change)))
                }
            }
        }

        coins = coinArray
        
        self.output?.success(coins: coins)
    }
}

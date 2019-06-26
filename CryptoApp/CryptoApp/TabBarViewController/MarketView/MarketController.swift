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
        // fazer request para pegar as moedas
             NotificationCenter.default.addObserver(self, selector: #selector(MarketController.fetchrealCoins), name: NSNotification.Name(rawValue: "didCompleteGetCoins"), object: nil)
    }
    
    func getCoins() -> [Coin] {
        
        return coins
    }
    
    @objc public func fetchrealCoins() {
        print("Got here")
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
//        let coin1 = Coin(name: "Bitcoin", initials: "BTC", imageView: "", value: "$ 9000.00", percentage: "+3.1 %")
//        let coin2 = Coin(name: "Etherium", initials: "ETH", imageView: "", value: "$ 9490.26", percentage: "+37.4 %")
//        let coin3 = Coin(name: "Litecoin", initials: "LTC", imageView: "", value: "$ 130.31", percentage: "-0.3 %")
//        let coin4 = Coin(name: "Ripple", initials: "XRP", imageView: "", value: "$ 0.49", percentage: "+13.4 %")
        print(coinArray)
        coins = coinArray
        self.output?.success(coins: coins)
    }
}

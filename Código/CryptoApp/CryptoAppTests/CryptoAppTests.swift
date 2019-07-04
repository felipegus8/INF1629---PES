//
//  CryptoAppTests.swift
//  CryptoAppTests
//
//  Created by Felipe Viberti on 06/06/19.
//  Copyright © 2019 Felipe Viberti. All rights reserved.
//

import XCTest
@testable import CryptoApp

class CryptoAppTests: XCTestCase {
    
    var marketController = MarketController()
    var coin1: Coin!
    var coin2: Coin!
    var coin3: Coin!
    var coins: [Coin]!

    override func setUp() {

        self.coin1 = nil
        self.coin2 = nil
        self.coin3 = nil
        self.coins = nil
    }

    override func tearDown() {
        self.coin1 = nil
        self.coin2 = nil
        self.coin3 = nil
        self.coins = nil
    }

    func testExample() {
        
        coin1 = Coin(name: "Bitcoin", initials: "BTC", imageView: "", value: "123", percentage: "123")
        coin2 = Coin(name: "Ripple", initials: "XRP", imageView: "", value: "123", percentage: "123")
        coin3 = Coin(name: "Cardano", initials: "CDN", imageView: "", value: "123", percentage: "123")
        coins = [coin1, coin2, coin3]
        
        let coinsOrdered = marketController.coinsOrder(coins: coins, type: .alphabeticallyName_A_Z)

        XCTAssertEqual(coinsOrdered, [coin1, coin3, coin2], "Vetor não ordenado")

    }
    


}

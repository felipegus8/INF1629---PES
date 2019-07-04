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

    func testCoin() {
        // Given
        var coin = Coin(name: "String", initials: "String", imageView: "String", value: "100", percentage: "15")

        // Then
        XCTAssertEqual(coin.name, "String")     
        XCTAssertEqual(coin.initials, "String")     
        XCTAssertEqual(coin.imageView, "String")     
        XCTAssertEqual(coin.value, "100") 
        XCTAssertEqual(coin.value, "15")       
        
}


}

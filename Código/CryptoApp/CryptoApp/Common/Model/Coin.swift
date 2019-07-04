//
//  Coin.swift
//  CryptoApp
//
//  Created by Wellington Bezerra on 6/19/19.
//  Copyright © 2019 Felipe Viberti. All rights reserved.
//

import UIKit

class Coin: Equatable {
   
    static func == (lhs: Coin, rhs: Coin) -> Bool {
        return lhs.name == rhs.name && lhs.initials == rhs.initials && lhs.imageView == rhs.imageView && lhs.value == rhs.value && lhs.percentage == rhs.percentage
    }
    
    
    var name: String = ""
    var initials: String = ""
    var imageView: String = ""
    var value: String = ""
    var percentage: String = ""
    
    init(name: String, initials: String, imageView: String, value: String, percentage: String) {
        
        self.name = name
        self.initials = initials
        self.imageView = imageView
        self.value = value
        self.percentage = percentage
    }
    
}

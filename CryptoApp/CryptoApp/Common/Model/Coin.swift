//
//  Coin.swift
//  CryptoApp
//
//  Created by Wellington Bezerra on 6/19/19.
//  Copyright © 2019 Felipe Viberti. All rights reserved.
//
import Foundation

final class Coin:NSObject {
    
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

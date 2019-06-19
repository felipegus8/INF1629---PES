//
//  MarketTableViewCell.swift
//  CryptoApp
//
//  Created by Wellington Bezerra on 6/18/19.
//  Copyright © 2019 Felipe Viberti. All rights reserved.
//

import UIKit

class MarketTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var coinImageView: UIImageView!
    @IBOutlet weak var coinInitials: UILabel!
    @IBOutlet weak var coinName: UILabel!
    @IBOutlet weak var coinValue: UILabel!
    @IBOutlet weak var coinPercentage: UILabel!
    @IBOutlet weak var backgroundViewCell: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundViewCell.layer.cornerRadius = 5.0
        
    }

}

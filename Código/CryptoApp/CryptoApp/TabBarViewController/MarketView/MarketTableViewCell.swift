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
        
        configureCell()
    }
    
    private func configureCell() {
        
        backgroundViewCell.layer.cornerRadius = 5.0
        
        selectionStyle = .none
        
        backgroundColor = UIColor.defaultColor
        
        backgroundViewCell.backgroundColor = UIColor.cellColor
        
        setupImageView()
    }
    
    private func setupImageView() {
        
        self.coinImageView.layer.borderWidth = 1.0
        self.coinImageView.layer.masksToBounds = false
        self.coinImageView.layer.cornerRadius = self.coinImageView.frame.size.width / 2
        self.coinImageView.layer.borderColor = UIColor.white.cgColor
        self.coinImageView.clipsToBounds = true
    }
    
    func setup(coin: Coin) {
        
        coinImageView.image = UIImage(named: "coin")
        
        coinInitials.text = coin.initials
        
        coinName.text = coin.name
        
        coinValue.text = "$" + String(Double(round(Double(1000)*Double(coin.value)!)/1000))
        
        coinPercentage.text = coin.percentage + "%"
        
    }

}

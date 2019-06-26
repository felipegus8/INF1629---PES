//
//  MarketViewController.swift
//  CryptoApp
//
//  Created by Wellington Bezerra on 6/18/19.
//  Copyright © 2019 Felipe Viberti. All rights reserved.
//

import UIKit

class MarketViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    
    private var controller = MarketController()
    private var coinsCopy: [Coin] = []
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        EvaluationDAO().get_coin_prices()
        //        EvaluationDAO().get_coin_predictions()
   
        controller.output = self

        view.backgroundColor = UIColor.white
        
        configureTableView()
        
        registerCell()
        
        controller.fetchCoins()
    }
    
    private func configureTableView() {
        
        self.tableView.backgroundColor = UIColor.white
    }
    
    func registerCell() {
        
        self.tableView.register(UINib(nibName: "MarketTableViewCell", bundle: nil), forCellReuseIdentifier: "MarketTableViewCell")
    }

}


extension MarketViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return coinsCopy.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MarketTableViewCell", for: indexPath) as? MarketTableViewCell else { return UITableViewCell() }
        
        cell.setup(coin: coinsCopy[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let registerVC = PredictionViewController(coinName: coinsCopy[indexPath.row].name)
        
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    
}

extension MarketViewController: MarketControllerOutput {
  
    func success(coins: [Coin]) {
        
        coinsCopy = coins
        
        tableView.reloadData()
    }
    
    func error() {
        
    }
    
}


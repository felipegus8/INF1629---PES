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
    private var filteredCoins: [Coin] = []
    private var hasSearchBarActivated: Bool = false
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        controller.output = self
        
        EvaluationDAO().get_coin_prices()
        //        EvaluationDAO().get_coin_predictions()
        
        controller.fetchCoins()
        
        configureView()
        
        configureTableView()
        
    }

}


extension MarketViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return hasSearchBarActivated ? filteredCoins.count : coinsCopy.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 110
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MarketTableViewCell", for: indexPath) as? MarketTableViewCell else { return UITableViewCell() }
        
        let coin = hasSearchBarActivated ? filteredCoins[indexPath.row] : coinsCopy[indexPath.row]
        
        cell.setup(coin: coin)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let coinName = hasSearchBarActivated ? filteredCoins[indexPath.row].name : coinsCopy[indexPath.row].name
        
        let coinInitials = hasSearchBarActivated ? filteredCoins[indexPath.row].initials : coinsCopy[indexPath.row].initials
        
        let registerVC = PredictionViewController(coinName: coinName, coinInitials: coinInitials)
        
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    
}


extension MarketViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredCoins.removeAll()
        
        guard let text = searchBar.text, text.count > 0 else {
            
            hasSearchBarActivated = false
            
            tableView.reloadData()
            
            return
        }
        
        hasSearchBarActivated = true
        
        filteredCoins = coinsCopy.filter({( coin : Coin) -> Bool in
            return coin.name.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
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

extension MarketViewController {
    
    private func configureView() {
        
        view.backgroundColor = UIColor.defaultColor
        
        titleLabel.textColor = UIColor.white
    }
    
    private func configureTableView() {
        
        registerCell()
        
        self.tableView.backgroundColor = UIColor.defaultColor
    }
    
    private func registerCell() {
        
        self.tableView.register(UINib(nibName: "MarketTableViewCell", bundle: nil), forCellReuseIdentifier: "MarketTableViewCell")
    }
    
}


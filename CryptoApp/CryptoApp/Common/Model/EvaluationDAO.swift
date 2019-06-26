//
//  EvaluationDAO.swift
//  CryptoApp
//
//  Created by Felipe Viberti on 26/06/19.
//  Copyright © 2019 Felipe Viberti. All rights reserved.
//

import Foundation
import Alamofire

public class EvaluationDAO {
    func get_coin_prices() {
        let headers: HTTPHeaders = [
            "Accepts": "application/json",
            "X-CMC_PRO_API_KEY": "ee535659-3b83-4132-83b0-aa4569b65ac1"
        ]
        let parameters: Parameters = [ "start":"1","limit":"5000","convert":"USD"]
        
        Alamofire.request("https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest", parameters: parameters, headers: headers).responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
    
        if let json = response.result.value {
            print("JSON: \(json)") // serialized json response
            }
    
        if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
            print("Data: \(utf8Text)") // original server data as UTF8 string
        }
    }
}
}

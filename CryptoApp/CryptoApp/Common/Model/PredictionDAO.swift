//
//  PredictionDAO.swift
//  CryptoApp
//
//  Created by Felipe Viberti on 26/06/19.
//  Copyright © 2019 Felipe Viberti. All rights reserved.
//

import Foundation
import Alamofire

public class PredictionDAO {
    
    func get_coin_predictions() {
        Alamofire.request("https://crypto-coin-pes.herokuapp.com").responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
        }
        
    }

}

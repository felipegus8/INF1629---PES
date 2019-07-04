//
//  PredictionDAO.swift
//  CryptoApp
//
//  Created by Felipe Viberti on 26/06/19.
//  Copyright © 2019 Felipe Viberti. All rights reserved.
//

import Foundation
import Alamofire
var prediction_json:Any?

public class PredictionDAO {
    
    func get_btc_predictions() {
        Alamofire.request("https://crypto-coin-pes.herokuapp.com/btc").responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
                prediction_json = json
            }
             NotificationCenter.default.post(Notification(name: Notification.Name.init(rawValue:"didCompleteGetPredictions")))
            
        }
        
    }
    
    func get_xrp_predictions() {
        Alamofire.request("https://crypto-coin-pes.herokuapp.com/xrp").responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
                prediction_json = json
            }
            NotificationCenter.default.post(Notification(name: Notification.Name.init(rawValue:"didCompleteGetPredictions")))
            
        }
        
    }

}

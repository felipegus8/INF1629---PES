//
//  PredictionViewController.swift
//  CryptoApp
//
//  Created by Wellington Bezerra on 6/18/19.
//  Copyright © 2019 Felipe Viberti. All rights reserved.
//

import UIKit
import SwiftChart
import CSV
class PredictionViewController: UIViewController, ChartDelegate {

    @IBOutlet weak var chart: Chart!
    var coinInitials:String!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    init(coinName: String,coinInitials:String) {
        self.coinInitials = coinInitials
        super.init(nibName: "PredictionViewController", bundle: nil)
        
        title = coinName
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        if (coinInitials == "BTC") {
            PredictionDAO().get_btc_predictions()
        }
        if (coinInitials == "XRP") {
            PredictionDAO().get_xrp_predictions()
        }
        if(coinInitials != "BTC" && coinInitials != "XRP") {
            segmentControl.isHidden = true
        }
        NotificationCenter.default.addObserver(self, selector: #selector(self.getPredictedValuesForChart), name: NSNotification.Name(rawValue: "didCompleteGetPredictions"), object: nil)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        chart.delegate = self
      
        
        currentPrice()
    }
    
    func didTouchChart(_ chart: Chart, indexes: [Int?], x: Double, left: CGFloat) {
        
        for (seriesIndex, dataIndex) in indexes.enumerated() {
            if dataIndex != nil {
                // The series at `seriesIndex` is that which has been touched
                let value = chart.valueForSeries(seriesIndex, atIndex: dataIndex)
            }
        }
    }
    
    func didFinishTouchingChart(_ chart: Chart) {
        
    }
    
    func didEndTouchingChart(_ chart: Chart) {
        
    }
    
    @IBAction func didSelectSegmentIndex(_ sender: UISegmentedControl) {
        
            switch segmentControl.selectedSegmentIndex {
                
            case 0:
                currentPrice()
                
            case 1:
                futurePrice()
                
            default:
                break;
            }
    }

    func getPreviousValuesForChart() -> [Double] {
        var valuesArray:[Double] = []
        let bundle = Bundle.main
        let path = bundle.path(forResource: "crypto-markets2", ofType: "csv")
        print(path)

        let stream = InputStream(fileAtPath: path!)!
        let csv = try! CSVReader(stream: stream,hasHeaderRow: true)
        while let row = csv.next() {
            if(row[1] == self.coinInitials) {
                valuesArray.append(Double(row[8])!)
            }
        }
        return valuesArray
    }
    
    private func currentPrice() {
        
        chart.removeAllSeries()
        var valuesArray = getPreviousValuesForChart()
        print(valuesArray)
        
        let series = ChartSeries(valuesArray)
        series.color = ChartColors.yellowColor()
        series.area = true
        chart.add(series)
    }
    
    private func futurePrice() {
        
        chart.removeAllSeries()
        var future_values = getPredictedValuesForChart()
        
        let series = ChartSeries(future_values)
        series.color = ChartColors.yellowColor()
        series.area = true
        chart.add(series)
    }

    
    @objc func getPredictedValuesForChart() -> [Double] {
        var future_values:[Double] = []
        let newArray = prediction_json as! NSArray
        for value in newArray {
            let newValue = value as! [String:Any]
            future_values.append(newValue["predicted_value"] as! Double)
    }
        return future_values

}
}

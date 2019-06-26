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
    
    init(coinName: String,coinInitials:String) {
        self.coinInitials = coinInitials
        super.init(nibName: "PredictionViewController", bundle: nil)
        
        title = coinName
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.getValuesForChart), name: NSNotification.Name(rawValue: "didCompleteGetPredictions"), object: nil)
        chart.delegate = self
        var valuesArray = getPreviousValuesForChart()
        print(valuesArray)
        let series = ChartSeries(valuesArray)
        series.color = ChartColors.yellowColor()
        series.area = true
        chart.add(series)
        
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
    
    @objc func getValuesForChart() {
        for(key,value) in prediction_json as! [String:Any] {
            print(key)
            print(value)
    }

}
}

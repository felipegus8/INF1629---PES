//
//  PredictionViewController.swift
//  CryptoApp
//
//  Created by Wellington Bezerra on 6/18/19.
//  Copyright © 2019 Felipe Viberti. All rights reserved.
//

import UIKit
import SwiftChart

class PredictionViewController: UIViewController, ChartDelegate {

    @IBOutlet weak var chart: Chart!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    init(coinName: String) {
        
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

    private func currentPrice() {
        
        chart.removeAllSeries()
        
        let series = ChartSeries([0, 6, 2, 8, 4, 7, 3, 10, 8])
        series.color = ChartColors.yellowColor()
        series.area = true
        chart.add(series)
    }
    
    private func futurePrice() {
        
        chart.removeAllSeries()
        
        let series = ChartSeries([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 20, 21, 22, 23, 24, 25, 26, 27, 27, 28, 29])
        series.color = ChartColors.yellowColor()
        series.area = true
        chart.add(series)
    }


}

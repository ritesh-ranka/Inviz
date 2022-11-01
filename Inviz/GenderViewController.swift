//
//  GenderViewController.swift
//  Inviz
//
//  Created by Pranshul Goyal on 31/10/22.
//

import UIKit
import Charts
class GenderViewController: UIViewController, ChartViewDelegate {
    var pieChart = PieChartView()
    override func viewDidLoad() {
        super.viewDidLoad()
        pieChart.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        pieChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width-10, height: self.view.frame.width-10)
        pieChart.center = view.center
        view.addSubview(pieChart)
        var entries = [
            ChartDataEntry(x:Double(1),y: Double(200)),
            ChartDataEntry(x:Double(1), y: Double(100))
        ]
        let set = PieChartDataSet(entries: entries, label: "Males, Females")
        set.colors = ChartColorTemplates.material()
        let data = PieChartData(dataSet: set)
        pieChart.data = data
    }


}

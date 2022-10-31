//
//  ArticlesViewController.swift
//  Inviz
//
//  Created by Pranshul Goyal on 31/10/22.
//

import UIKit
import Charts
class ArticlesViewController: UIViewController,ChartViewDelegate {
    var barChart = BarChartView()
    override func viewDidLoad() {
        super.viewDidLoad()
        barChart.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        barChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width-10, height: self.view.frame.width-10)
        barChart.center = view.center
        view.addSubview(barChart)
        var entries = [
            BarChartDataEntry(x:2018,y: Double(200)),
            BarChartDataEntry(x:2019, y: Double(100)),
            BarChartDataEntry(x:2020,y: Double(300)),
            BarChartDataEntry(x:2021, y: Double(400)),
            BarChartDataEntry(x:2022,y: Double(200))
        ]
        let set = BarChartDataSet(entries: entries, label: "Articles, Year")
        set.colors = ChartColorTemplates.material()
        let data = BarChartData(dataSet: set)
        barChart.data = data
    }

    


}

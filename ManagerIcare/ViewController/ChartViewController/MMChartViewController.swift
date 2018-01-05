//
//  MMChartViewController.swift
//  ManagerIcare
//
//  Created by Bui Giang on 1/4/18.
//  Copyright © 2018 Bui Giang. All rights reserved.
//

import UIKit
import Charts

class MMChartViewController: UIViewController {

    @IBOutlet weak var lineCharView: LineChartView!
    let arrayMonth:[String] = ["Thang1","Thang2","Thang3","Thang4","Thang5","Thang6","Thang7","Thang8","Thang9","Thang10","Thang11","Thang12"]
    let arrayValue:[Double] = [10,20,30,40,50,60,70,80,90,10,11,12]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lineCharView.noDataText = "Chua co Data"
        setBarChar(name: arrayMonth, value: arrayValue)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func setBarChar(name:[String],value:[Double]) {
        var dataArray:[BarChartDataEntry] = []
        
        for i in 0..<name.count {
            let charData:BarChartDataEntry = BarChartDataEntry(x: Double(i), y: arrayValue[i])
            dataArray.append(charData)
        }
        let dataSet:LineChartDataSet = LineChartDataSet(values: dataArray, label: "Khong biet day la cai meo j")
        let data:LineChartData = LineChartData(dataSet: dataSet)
        lineCharView.data = data
    }
    

}

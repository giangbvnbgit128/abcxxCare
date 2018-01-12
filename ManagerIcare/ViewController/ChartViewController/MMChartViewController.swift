//
//  MMChartViewController.swift
//  ManagerIcare
//
//  Created by Bui Giang on 1/4/18.
//  Copyright © 2018 Bui Giang. All rights reserved.
//

import UIKit
import Charts
import Realm
import RealmSwift


class MMChartViewController: UIViewController {

    @IBOutlet weak var lineCharView: LineChartView!
    var arrayWeek:[Int] = []
    
    var countWeek:Int = 10
    var arrayValue:[Double] = []
    var des:String = ""
    
    var flagHeight:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lineCharView.noDataText = "Chua co Data"
       
        self.arrayWeek = getData().0
        if flagHeight {
            self.arrayValue = getData().1
        } else {
            self.arrayValue = getData().2
        }
         setBarChar(name: self.arrayWeek, value: self.arrayValue)
//        self.arrayValue
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func getData() -> ([Int],[Double],[Double]) {
        var arrayData:[BaseModelHealthy] = []
        let realm = try! Realm()
        let puppies = realm.objects(BaseModelHealthy.self)
        arrayData = Array(puppies).reversed()
        
        var arrayHeight:[Double] = []
        var arrayWeight:[Double] = []
        var arrayWeek:[Int] = []
        
        for i in 0..<arrayData.count {
            arrayHeight.append(arrayData[i].height)
            arrayWeight.append(arrayData[i].weight)
            arrayWeek.append(arrayData[i].week)
        }
        return (arrayWeek,arrayHeight,arrayWeight)
    }
    
    func setBarChar(name:[Int],value:[Double]) {
        var dataArray:[BarChartDataEntry] = []
        
        for i in 0..<self.arrayWeek.count {
            let charData:BarChartDataEntry = BarChartDataEntry(x: Double(name[i]), y: value[i])
            dataArray.append(charData)
        }
        let dataSet:LineChartDataSet = LineChartDataSet(values: dataArray, label: "Chỉ số \(self.des) theo tuần")
        let data:LineChartData = LineChartData(dataSet: dataSet)
        lineCharView.data = data
    }
    
    @IBAction func actionClose(_ sender: Any) {
        self.dismiss(animated: true) {
            
        }
    }
    
}

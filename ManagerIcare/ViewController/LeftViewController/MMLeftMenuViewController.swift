//
//  MMLeftMenuViewController.swift
//  ManagerIcare
//
//  Created by Bui Giang on 1/2/18.
//  Copyright © 2018 Bui Giang. All rights reserved.
//

import UIKit
import Realm
import RealmSwift
import AKSideMenu

class MMLeftMenuViewController: UIViewController {

    @IBOutlet weak var nscontraintTopForLeftMenu: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nscontraintSpacingTopRight: NSLayoutConstraint!
    
    var arrItem:[String] = ["Chiều cao","Cân Nặng","Tuổi"]
    
    var notificationUpdateProfile:Bool = false
    var countDayStr:String = ""
    var countWeek:Int = 0
    
    var nameProfile:String = "No Name"
    var height:Double = 0.0
    var weight:Double = 0.0
    var txtTitle:String = ""
    var maxWeek:Int = 0
    
    var arrayHealthyModel:[BaseModelHealthy] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSpacingRight()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none

        let viewCell = UINib(nibName: MMProfileTableViewCell.className, bundle: nil)
        tableView.register( viewCell, forCellReuseIdentifier: MMProfileTableViewCell.className)
        
        let viewCellItem = UINib(nibName: MMItemProfileTableViewCell.className, bundle: nil)
        tableView.register( viewCellItem, forCellReuseIdentifier: MMItemProfileTableViewCell.className)
        
        self.nscontraintTopForLeftMenu.constant = UIScreen.mainHeight * 0.1 * 0.5
        self.nscontraintSpacingTopRight.constant = self.setupSpacingRight()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.getData()
        if let datestr = UserDefaults.value(forKey: DataConfig.udBirtDay) as? Date {
            let fday:Date = Date(month: datestr.month, day: datestr.day, year: datestr.year)!
            let fs = FengShui(checnkg: .VN)
            let dateUI = NSDate()
            let countDay = fs.SubtractionDateWithTowMonth(firstDate: fday, secondDate: dateUI as Date)
            
            let realm = try! Realm()
            self.maxWeek = realm.objects(BaseModelHealthy.self).max(ofProperty: "week") as Int? ?? 0
            
            
            // tinh ra duoc co bao nhieu tuan
           countDayStr = self.getCountDatStr(countDay: countDay)

            countWeek = countDay/7
            
            if countDay%7 != 0 {
                self.countWeek += 1
            }
            print("====maxWeek =\(self.maxWeek) countWeek= \(self.countWeek)") // la so tuan lon             nhat luu trong database
            if self.countWeek > self.maxWeek {
                self.notificationUpdateProfile = true
                self.arrItem.append("Update")
            } else {
                self.notificationUpdateProfile = false
                if self.arrItem.count > 4 {
                     self.arrItem.remove(at: 4)
                }
               
            }
            
           
            
        }
    }
    
    func getCountDatStr(countDay:Int) -> String {
        
        var year:Int = 0
        var month:Int = 0
        var week:Int = 0
        var day:Int  = 0
        let countDay1:Int = 1010
        let duforyear = countDay%365
        year = countDay/365
        let duForMonth = duforyear%30
        month = duforyear/30
        let duForWeek = duForMonth%7
        week = duForMonth/7
        day = duForWeek
        print("====day = year = \(year) =month \(month) week =\(week) day =\(day)" )
        
        

        
        var rs:String = ""
        if year != 0 {
            rs = "\(year) năm "
        }
        if month != 0 {
            rs += "\(month) tháng "
        }
        
        if week != 0 {
            rs += "\(week) tuần "
        }
        
        if day != 0 {
            rs += "\(day) ngày"
        }
        print("===== rs = \(rs)")
        return rs
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func getData() {
        if tableView != nil {
            let realm = try! Realm()
            let puppies = realm.objects(BaseModelHealthy.self)
            self.arrayHealthyModel = Array(puppies).reversed()
            print("Puppies = \(puppies.count)")
            tableView.reloadData()
        }
    }
    
    func setupSpacingRight() -> CGFloat {
        
        if ScreenSize.iSIPhone4OrLess {
            return 30
        } else if ScreenSize.IsIPhone5 {
            return 55
        } else if ScreenSize.IsIPhone6 {
            return 80
        } else {
            return 90 * Ratio.widthIPhone6
        }
        
    }

}
extension MMLeftMenuViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.notificationUpdateProfile {
            return 6
        } else {
            return 5
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        
        if self.arrayHealthyModel.count > 0 {
            let heal = self.arrayHealthyModel[0]
            height = heal.height
            weight = heal.weight
        }
        
        if indexPath.row == 0 {
          let cell = tableView.dequeueReusableCell(withIdentifier: MMProfileTableViewCell.className) as! MMProfileTableViewCell
            
            cell.configCell()
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: MMItemProfileTableViewCell.className) as! MMItemProfileTableViewCell
            var textValue:String = ""
            switch indexPath.row {
            case 1:
                txtTitle = "Chiều Cao"
                textValue = "\(height) cm"
            case 2:
                txtTitle = "Cân Nặng"
                textValue = "\(weight) kg"
            case 3:
                txtTitle = "Tuổi"
                textValue = self.countDayStr
            default:
                if self.notificationUpdateProfile && indexPath.row == 4 {
                    txtTitle = ""
                    cell.flag = true
                } else {
                    txtTitle = ""
                    textValue = ""
                }
            }
            
            cell.configCell(title: txtTitle, value: textValue)
            cell.selectionStyle = .none
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 || indexPath.row == 4{
            let viewVC = MMProfileViewController()
            if indexPath.row == 0{
                viewVC.flagUpdateProfile = false
            } else {
                viewVC.flagUpdateProfile = true
            }
            
            viewVC.weidth = self.weight
            viewVC.height = self.height
            viewVC.strName = self.nameProfile
            viewVC.countWeek = self.countWeek
            self.present(viewVC, animated: false, completion: {
                
            })
        } else if indexPath.row == 1 {
            let viewVC = MMChartViewController()
            viewVC.flagHeight = true
            self.present(viewVC, animated: true, completion: {
                
            })
        } else if indexPath.row == 2 {
            let viewVC = MMChartViewController()
            viewVC.flagHeight = false
            self.present(viewVC, animated: true, completion: {
                
            })
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 200
        } else {
            return 45
        }
    }
}


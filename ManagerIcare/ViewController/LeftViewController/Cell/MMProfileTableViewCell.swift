//
//  MMProfileTableViewCell.swift
//  ManagerIcare
//
//  Created by Bui Giang on 1/2/18.
//  Copyright © 2018 Bui Giang. All rights reserved.
//

import UIKit

class MMProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var titleYear: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgAvarta: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if let imageData = UserDefaults.value(forKey: "keyImage") as? Data {
            let IMGE = UIImage(data: imageData)!
            self.imgAvarta.image = IMGE
        }
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configCell()  {
        self.imgAvarta.layer.cornerRadius = imgAvarta.layer.frame.width/2
        self.imgAvarta.border(color: .black, radius: imgAvarta.layer.frame.width/2, width: 1)
        if let nameC = UserDefaults.value(forKey: DataConfig.udKeyName) as? String {
            self.lblName.text = nameC
        }
        
        if let datestr = UserDefaults.value(forKey: DataConfig.udBirtDay) as? Date {
            var dayStr:String = "\(datestr.day)"
            var thangStr:String = "\(datestr.month)"
            if datestr.day < 10 {
                dayStr = "0\(datestr.day)"
            }
            
            if datestr.month < 10 {
                thangStr = "0\(datestr.month)"
            }
            
            self.titleYear.text = "\(dayStr)-\(thangStr)-\(datestr.year)"
            let fday:Date = Date(month: datestr.month, day: datestr.day, year: datestr.year)!
            let fs = FengShui(checnkg: .VN)
            let dateUI = NSDate()
            let countDay = fs.SubtractionDateWithTowMonth(firstDate: fday, secondDate: dateUI as Date)
            print("===== countDay \(countDay) currnet Day =\(dateUI) firtDay = \(fday)")
            
        } else {
            print("Error")
        }
        
        
    }
    
}

//
//  MMVaccinationalTableViewCell.swift
//  ManagerIcare
//
//  Created by Bui Giang on 12/31/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//

import UIKit

class MMVaccinationalTableViewCell: UITableViewCell {

    @IBOutlet weak var lblNumberInForCell: UILabel!
    @IBOutlet weak var cicrleView: UIView!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDes: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       self.cicrleView.layer.cornerRadius = cicrleView.frame.width/2
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configCell(number:Int,vaccitional:MMVaccinationalModel) {
        lblNumberInForCell.text = "\(number)"
        
        lblTitle.text  = vaccitional.title
        self.lblDes.text = vaccitional.description
    
        if vaccitional.type == 1 {
            self.lblTitle.textColor = .black
            self.lblDes.textColor = .black
            self.lblNumberInForCell.textColor = .black
        } else {
            self.lblTitle.textColor = .red
            self.lblDes.textColor = .red
            self.lblNumberInForCell.textColor = .red
        }
        
        
    }
    
}

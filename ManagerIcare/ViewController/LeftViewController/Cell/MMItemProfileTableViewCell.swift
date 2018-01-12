//
//  MMItemProfileTableViewCell.swift
//  ManagerIcare
//
//  Created by Bui Giang on 1/2/18.
//  Copyright © 2018 Bui Giang. All rights reserved.
//

import UIKit

class MMItemProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var notiView: UIView!
    @IBOutlet weak var viewUpdateProfile: UIView!
    @IBOutlet weak var lblValue: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    var flag:Bool = false
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.notiView.layer.cornerRadius = self.notiView.frame.width/2
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(title:String,value:String) {
        self.lblTitle.text = title
        self.lblValue.text = value
        if flag == true {
            self.viewUpdateProfile.isHidden = false
        } else {
            self.viewUpdateProfile.isHidden = true
            
        }
        
    }
    
}

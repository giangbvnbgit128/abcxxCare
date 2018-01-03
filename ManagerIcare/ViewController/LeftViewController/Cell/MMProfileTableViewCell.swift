//
//  MMProfileTableViewCell.swift
//  ManagerIcare
//
//  Created by Bui Giang on 1/2/18.
//  Copyright © 2018 Bui Giang. All rights reserved.
//

import UIKit

class MMProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgAvarta: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configCell(title:String)  {
        self.imgAvarta.layer.cornerRadius = imgAvarta.layer.frame.width/2
        self.imgAvarta.border(color: .black, radius: imgAvarta.layer.frame.width/2, width: 1)
        
    }
    
}

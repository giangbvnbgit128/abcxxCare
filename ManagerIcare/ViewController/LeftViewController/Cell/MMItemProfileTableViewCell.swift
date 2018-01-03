//
//  MMItemProfileTableViewCell.swift
//  ManagerIcare
//
//  Created by Bui Giang on 1/2/18.
//  Copyright © 2018 Bui Giang. All rights reserved.
//

import UIKit

class MMItemProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(title:String) {
        self.lblTitle.text = title
    }
}

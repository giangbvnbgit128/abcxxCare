//
//  headerCellTableViewCell.swift
//  ManagerIcare
//
//  Created by Bui Giang on 12/24/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//

import UIKit

class headerCellTableViewCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       lblTitle.text = "Note suc khoe firebase"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

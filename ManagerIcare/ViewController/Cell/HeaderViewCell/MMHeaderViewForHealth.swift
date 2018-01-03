//
//  MMHeaderViewForHealth.swift
//  ManagerIcare
//
//  Created by Bui Giang on 12/24/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//

import UIKit

class MMHeaderViewForHealth: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var lol: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(self.className, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }
    
    func configCell(title:String)  {
        self.lol.text = title
    }
}

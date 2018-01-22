//
//  MMHealthCollectionViewCell.swift
//  ManagerIcare
//
//  Created by Bui Giang on 12/23/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//

import UIKit

class MMHealthCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var viewAvarta: UIView!
    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var imageAvarta: UIImageView!
    @IBOutlet weak var imgIconPlay: UIImageView!
    @IBOutlet weak var lbltitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageAvarta.layer.cornerRadius = 15
        self.imageAvarta.border(color: .black, radius: 15, width: 1)
    }
    
    func configCell(data:MMHealthModel) {
        
        imageAvarta.sd_setImage(with: URL(string: data.urlImage), placeholderImage: UIImage(named: "pikachu.jpg"))

        if data.urlWeb == "" {
            self.imgIconPlay.isHidden = false
        } else {
            self.imgIconPlay.isHidden = true
        }
        self.lbltitle.text = data.title
        self.lblContent.text = data.content
        
    }

}

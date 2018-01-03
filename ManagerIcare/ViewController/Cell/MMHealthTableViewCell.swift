//
//  MMHealthTableViewCell.swift
//  ManagerIcare
//
//  Created by Bui Giang on 12/23/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//

import UIKit
import SDWebImage

class MMHealthTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    var arrayItem:[MMHealthModel] = []
    var nav:UINavigationController?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .red
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(MMHealthCollectionViewCell.self, forCellWithReuseIdentifier: MMHealthCollectionViewCell.className)

        let viewCell = UINib(nibName: MMHealthCollectionViewCell.className, bundle: nil)
        collectionView.register(viewCell, forCellWithReuseIdentifier: "CellForCollection")
    
    }
    
}
extension MMHealthTableViewCell: UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrayItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellForCollection", for: indexPath) as! MMHealthCollectionViewCell
        let item = self.arrayItem[indexPath.row]
        cell.configCell(urlImage: item.urlImage, title: item.title, content: item.content)
        
        return cell
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 232)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewVC = NationalVaccinationViewController()
        
        self.nav?.pushViewController(viewVC, animated: true)
    }
    
}



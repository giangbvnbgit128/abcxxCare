//
//  MMLeftMenuViewController.swift
//  ManagerIcare
//
//  Created by Bui Giang on 1/2/18.
//  Copyright © 2018 Bui Giang. All rights reserved.
//

import UIKit

class MMLeftMenuViewController: UIViewController {

    @IBOutlet weak var nscontraintTopForLeftMenu: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nscontraintSpacingTopRight: NSLayoutConstraint!
    
    let arrayItem:[String] = ["Chiều Cao","Cân Năng","Tuổi","Theo Dõi Phát Triển","Đăng Nhập"]
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
        
        self.nscontraintTopForLeftMenu.constant = self.setupSpacingRight()
        self.nscontraintSpacingTopRight.constant = UIScreen.mainHeight * 0.1 * 0.5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
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
        return self.arrayItem.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
          let cell = tableView.dequeueReusableCell(withIdentifier: MMProfileTableViewCell.className) as! MMProfileTableViewCell
            cell.configCell(title: "Mr.TUn")
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: MMItemProfileTableViewCell.className) as! MMItemProfileTableViewCell
            cell.configCell(title: self.arrayItem[indexPath.row - 1])
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let viewVC = MMProfileViewController()
            self.present(viewVC, animated: true, completion: nil)
        } else if indexPath.row == self.arrayItem.count - 1 {
            let viewVC = MMChartViewController()
            self.present(viewVC, animated: true, completion: nil)
            
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


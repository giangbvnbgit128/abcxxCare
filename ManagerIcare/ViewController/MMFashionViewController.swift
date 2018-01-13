//
//  MMFashionViewController.swift
//  ManagerIcare
//
//  Created by Bui Giang on 12/23/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//

import UIKit

class MMFashionViewController: MMBaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    @IBAction func clickMenu(_ sender: Any) {
        self.clickMenu()
    }
    @IBAction func actionAdData(_ sender: Any) {
        let viewVC = MMAddHealthViewController()
        viewVC.edgesForExtendedLayout = []
        viewVC.keyDataBase = "dbNutrition"
//        viewVC.arrayNote = self.arrayKey
//        viewVC.idForItem = self.arrayId.max() ?? 0
        self.navigationController?.pushViewController(viewVC, animated: true)
    }
}



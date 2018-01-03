//
//  MMBaseViewController.swift
//  ManagerIcare
//
//  Created by Bui Giang on 12/23/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import AKSideMenu

class MMBaseViewController: UIViewController {
    var ref: DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
    }
    
    func clickMenu() {
    
        self.sideMenuViewController?.presentLeftMenuViewController()
    
    }
    // set one viewcontroller in left view
    
    
}

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
    
    func showAler(message:String,title:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
        
    }
}

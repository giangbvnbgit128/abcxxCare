//
//  MMSplashScreen.swift
//  ManagerIcare
//
//  Created by Bui Giang on 1/2/18.
//  Copyright © 2018 Bui Giang. All rights reserved.
//

import Foundation
import AKSideMenu

class MMSplashScreen: MMBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func actionClick(_ sender: Any) {
        
        let viewTabbar = storyboard?.instantiateViewController(withIdentifier: "tabbarkey")
        let letftViewContrller = MMLeftMenuViewController.vc()
        
        
        let akViewVC = AKSideMenu(contentViewController: viewTabbar!, leftMenuViewController: letftViewContrller, rightMenuViewController: nil)
        appDelegate.window?.rootViewController = akViewVC
    }
}

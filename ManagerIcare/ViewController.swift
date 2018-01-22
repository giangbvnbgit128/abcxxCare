//
//  ViewController.swift
//  ManagerIcare
//
//  Created by Bui Giang on 12/22/17.
//  Copyright © 2017 Bui Giang. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let str:String = "Do any additional setup after loading the view, typically from a nib."
        let encodeContent = str.data(using: .utf8)
        print("======= \(encodeContent)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


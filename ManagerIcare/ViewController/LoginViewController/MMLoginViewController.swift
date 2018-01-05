//
//  MMLoginViewController.swift
//  ManagerIcare
//
//  Created by Bui Giang on 1/4/18.
//  Copyright © 2018 Bui Giang. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class MMLoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
       let longinButton = FBSDKLoginButton()
       self.view.addSubview(longinButton)
        longinButton.frame = CGRect(x: self.view.frame.width/2 - 100, y: self.view.frame.height/2 - 25, width: 200, height: 50)
        
        longinButton.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func actionClose(_ sender: Any) {
        self.dismiss(animated: true) {
            
        }
    }
    

}

extension MMLoginViewController: FBSDKLoginButtonDelegate {
 
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("==== LogButton")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            
            print("Error")
        }
        // login xong thi sao. lamf cai chi se la chinh
        print("Result Success = \(result)")
    }
    
}

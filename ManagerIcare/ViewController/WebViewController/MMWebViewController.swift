//
//  MMWebViewController.swift
//  ManagerIcare
//
//  Created by Bui Giang on 1/13/18.
//  Copyright © 2018 Bui Giang. All rights reserved.
//

import UIKit

class MMWebViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let strVideo:String = "https://eva.vn/ba-bau/11-dieu-ky-quac-khi-mang-thai-chinh-bac-si-cung-it-khi-tiet-lo-voi-me-bau-c85a330521.html"
        let urlVideo:URL = URL(string: strVideo)!
        self.webView.loadRequest(URLRequest(url: urlVideo))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

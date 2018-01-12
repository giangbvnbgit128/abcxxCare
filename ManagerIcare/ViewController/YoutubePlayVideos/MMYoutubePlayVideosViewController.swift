//
//  MMYoutubePlayVideosViewController.swift
//  ManagerIcare
//
//  Created by Bui Giang on 1/8/18.
//  Copyright © 2018 Bui Giang. All rights reserved.
//

import UIKit

class MMYoutubePlayVideosViewController: UIViewController {

    let idVideo:String = "doG2JkQ-yRs"
    
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.getVideo(id: idVideo)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionClickExit(_ sender: Any) {
        
    }
    
    func getVideo(id:String) {
        let strVideo:String = "https://www.youtube.com/embed/\(id)"
        let urlVideo:URL = URL(string: strVideo)!
        self.webView.loadRequest(URLRequest(url: urlVideo))
    }

}

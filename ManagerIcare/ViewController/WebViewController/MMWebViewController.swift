//
//  MMWebViewController.swift
//  ManagerIcare
//
//  Created by Bui Giang on 1/13/18.
//  Copyright © 2018 Bui Giang. All rights reserved.
//

import UIKit
import WebKit

class MMWebViewController: UIViewController, UIWebViewDelegate, WKUIDelegate {

    @IBOutlet weak var indicatorLoading: UIActivityIndicatorView!
    @IBOutlet weak var webView: UIWebView!
    let webKitContent:WKWebView = WKWebView()
    var strVideo:String = ""
    var backButton: UIButton = UIButton()
    var forwardButton: UIButton = UIButton()
    var flagLoading:Bool = false
    var naviButtonView:UIView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initControlWebView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        let urlVideo:URL = URL(string: strVideo)!
        self.webKitContent.load(URLRequest(url: urlVideo))
        self.webKitContent.frame = self.view.frame
        
        self.webKitContent.navigationDelegate = self
        self.webKitContent.uiDelegate = self
        
        self.view.addSubview(self.webKitContent)
    }
    
    func initControlWebView() {
        naviButtonView = UIView(frame: CGRect(x: 10, y: 0,width: UIScreen.main.bounds.width, height: 40))
        backButton = UIButton(type: UIButtonType.custom)
        backButton.frame = CGRect(x: UIScreen.main.bounds.width - 146.4, y: 0,width: 40, height: 40)
        enableBackButton(isShow: false)
        backButton.addTarget(self, action: #selector(MMWebViewController.handleGoBack), for: .touchUpInside)
        forwardButton = UIButton(type: UIButtonType.custom)
        
        forwardButton.frame = CGRect(x: UIScreen.main.bounds.width - 97 , y: 0,width: 40, height: 40)
        enableForwardButton(isShow: false)
        forwardButton.addTarget(self, action: #selector(MMWebViewController.handleGoForward), for: .touchUpInside)
        naviButtonView.addSubview(backButton)
        naviButtonView.addSubview(forwardButton)
        self.navigationItem.titleView = naviButtonView
        
        backButton.isEnabled = false
        forwardButton.isEnabled = false
        
        URLCache.shared.removeAllCachedResponses()
        URLCache.shared.diskCapacity = 0
        URLCache.shared.memoryCapacity = 0
        NotificationCenter.default.addObserver(self, selector: #selector(MMWebViewController.updateUI), name: NSNotification.Name(rawValue: "keyspecial"), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
  
    }
    deinit {
        // Release all recoureces
        // perform the deinitialization
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self, name: NSNotification.Name(rawValue: "keyspecial"), object: nil)
    }
    
    @objc func updateUI() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            print("baclwebview CangoBack updateUI= \(self.webKitContent.canGoBack) forward = \(self.webKitContent.canGoForward)")
            
            self.backButton.isEnabled = self.webKitContent.canGoBack
            self.forwardButton.isEnabled = self.webKitContent.canGoForward
            self.enableBackButton(isShow: self.webKitContent.canGoBack)
            self.enableForwardButton(isShow: self.webKitContent.canGoForward)
            
        }
        
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        if !self.flagLoading {
           self.indicatorLoading.startAnimating()
        }
        
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.indicatorLoading.stopAnimating()
        self.flagLoading = true
        self.indicatorLoading.isHidden = true
    }
    
    @objc func handleGoBack() {
        if webKitContent.canGoBack {
            webKitContent.goBack()
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "keyspecial"), object: self)
    }
    
    @objc func handleGoForward() {
        if webKitContent.canGoForward {
            webKitContent.goForward()
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "keyspecial"), object: self)
    }

}
extension MMWebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            self.showStatusBarLoading()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.hideStatusBarLoading()
        backButton.isEnabled = self.webKitContent.canGoBack
        self.enableBackButton(isShow: self.webKitContent.canGoBack)
        forwardButton.isEnabled = self.webKitContent.canGoForward
        self.enableForwardButton(isShow: self.webKitContent.canGoForward)
        
    }
    
    func enableBackButton(isShow:Bool) {
        var imageback = UIImage()
        if isShow {
            imageback = UIImage(named: "icon_pageprev_on")!
        } else {
            imageback = UIImage(named: "icon_pageprev_off")!
        }
        backButton.setImage(imageback, for: UIControlState())
    }
    
    func enableForwardButton(isShow:Bool) {
        
        var imageforward = UIImage()
        if isShow {
            imageforward = UIImage(named: "icon_pagenext_on")!
        } else {
            imageforward = UIImage(named: "icon_pagenext_off")!
        }
        self.forwardButton.setImage(imageforward, for: UIControlState())
        
    }
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        
    }
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        
    }
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        
    }
    func webView(_ webView: WKWebView, commitPreviewingViewController previewingViewController: UIViewController) {
        
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.hideStatusBarLoading()
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping ((WKNavigationActionPolicy) -> Void)) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "keyspecial"), object: self)
        decisionHandler(.allow)
        
    }
    
}



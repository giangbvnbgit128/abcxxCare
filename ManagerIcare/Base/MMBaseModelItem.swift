//
//  MMBaseModelItem.swift
//  ManagerIcare
//
//  Created by Bui Giang on 1/13/18.
//  Copyright © 2018 Bui Giang. All rights reserved.
//

import Foundation

class MMBaseModelItem {
    var id:Int = 0
    var title:String = ""
    var content:String = ""
    var urlImage:String = ""
    var urlWeb:String = ""
    var urlVideo:String = ""
    
    init() {
        
    }
    
    init(object:Any) {
        if let dic = object as? Dictionary<String,Any> {
            print("=====Dic \(dic)")
            
            if let idc = dic["id"] as? String {
                self.id = Int(idc) ?? 0
            }
            
            
            if let titl = dic["title"] as? String {
                self.title = titl
            }
            
            if let urli = dic["urlimage"] as? String {
                self.urlImage = urli
            }
            
            if let urlimage = dic["urlvideo"] as? String {
                self.urlVideo = urlimage
            }
            
            if let urlw = dic["urlweb"] as? String {
                self.urlWeb = urlw
            }
            
            if let cont = dic["content"] as? String {
                self.content = cont
            }
            
        } else {
            self.id = 0
            self.title = ""
            self.urlImage = ""
            self.urlVideo = ""
            self.urlWeb = ""
            self.content = ""
        }
    }
}

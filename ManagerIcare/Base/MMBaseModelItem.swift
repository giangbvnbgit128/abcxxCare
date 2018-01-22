//
//  MMBaseModelItem.swift
//  ManagerIcare
//
//  Created by Bui Giang on 1/13/18.
//  Copyright © 2018 Bui Giang. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class MMBaseModelItem: NSObject {
    @objc dynamic var id:Int = 0
    @objc dynamic var title:String = ""
    @objc dynamic var content:String = ""
    @objc dynamic var urlImage:String = ""
    @objc dynamic var urlWeb:String = ""
    @objc dynamic var urlVideo:String = ""
    
    override init() {
        
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

//
//  cachItem.swift
//  ManagerIcare
//
//  Created by Bui Giang on 1/19/18.
//  Copyright © 2018 Bui Giang. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class cachItem: Object {
    @objc dynamic var id:Int = 0
    @objc dynamic var title:String = ""
    @objc dynamic var content:String = ""
    @objc dynamic var urlImage:String = ""
    @objc dynamic var urlWeb:String = ""
    @objc dynamic var urlVideo:String = ""
    
}

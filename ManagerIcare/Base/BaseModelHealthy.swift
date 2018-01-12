//
//  BaseModelHealthy.swift
//  ManagerIcare
//
//  Created by Bui Giang on 1/5/18.
//  Copyright © 2018 Bui Giang. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class BaseModelHealthy: Object  {
    @objc dynamic var name:String = ""
    @objc dynamic var height:Double = 0
    @objc dynamic var weight:Double = 0
    @objc dynamic var date:String = ""
    @objc dynamic var week:Int = 0
    @objc dynamic var id:Int = 0
    func incrementID(modelName:Object.Type) -> Int {
        let realm = try! Realm()
        return (realm.objects(modelName).max(ofProperty: "id") as Int? ?? 0) + 1
    }

}

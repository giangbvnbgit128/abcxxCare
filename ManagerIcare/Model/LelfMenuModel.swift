//
//  LelfMenuModel.swift
//  ManagerIcare
//
//  Created by Bui Giang on 1/4/18.
//  Copyright © 2018 Bui Giang. All rights reserved.
//

import Foundation

enum typeLeftMenu:Int {
    case profile = 1
    case itemChild = 2
    case itemB = 3
    case none = 0
}

class MMLeftMenuModel {
    var title:String = ""
    var type:typeLeftMenu = .none
    
}

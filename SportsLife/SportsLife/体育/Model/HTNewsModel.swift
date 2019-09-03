//
//  HTNewsModel.swift
//  SportsLife
//
//  Created by seven on 2019/8/26.
//  Copyright © 2019 west. All rights reserved.
//

import UIKit
import SwiftyJSON

class HTNewsModel: NSObject {
    var thumbnail = ""
    var title = ""
    var updatetime = ""
    var url = ""
    
    convenience init(json:JSON) {
        self.init()
        self.thumbnail = json["thumbnail"].stringValue
        self.title = json["title"].stringValue
        self.updatetime = json["updatetime"].stringValue
        self.url = json["url"].stringValue

    }
}

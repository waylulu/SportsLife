//
//  CradsModel.swift
//  SportsLife
//
//  Created by seven on 2019/8/2.
//  Copyright © 2019 west. All rights reserved.
//

import UIKit
import SwiftyJSON
@objcMembers
class CardsModel {
    
    ///头部图片
    var titleImage = ""
    ///标题
    var title = ""
    ///内容
    var detail = ""
    ///选中图片
    var isChoose:Bool = false
    
    
    convenience init(json:JSON) {
        self.init()
        
        self.titleImage = json["titleImage"].stringValue;
        self.title = json["title"].stringValue;
        self.detail = json["detail"].stringValue;
        self.isChoose = json["isChoose"].boolValue

    }

}

class PayTypeModel {
    ///图片
    var headerImage = ""
    ///标题
    var title = ""
    ///内容模型
    var detail = [CardsModel]()
    
    convenience init(json:JSON) {
        self.init()
        
        self.headerImage = json["headerImage"].stringValue;
        self.title = json["title"].stringValue;
        
        for dic in json["detail"].arrayValue {
            self.detail.append(CardsModel.init(json:dic))
        }
    }
    
    
    
}

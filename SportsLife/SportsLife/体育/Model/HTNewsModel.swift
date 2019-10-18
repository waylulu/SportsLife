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
    
    var color = ""
    var shortTitle = "阿利森：梅西是史上最佳之一，能三次战胜他是全队功劳"
    var from_url = "7851"
    var updatetime = "2019-10-14 00:11:07"
    var position = "首页小字区域二"
    var filename = "5da34c9bb6b93"
    var way = "2019_10_14-news-zuqiu-5da34c9bb6b93"
    var from_name = "利物浦回声报"
    var saishiid = "0"
    var porder = "4"
    var butuijian = "0"
    var indextitle = "阿利森：梅西是史上最佳之一，能三次战胜他是全队功劳"
    var describe =  ""

    
    var createtime = "2019-10-11 08"
    var disable_black = false
    var label = "中超,中国男足,广州恒大,足球"
    var match_id = "0"
    var model = "news"
    var pinglun = "2019_10_11-news-zuqiu-5d9fcd4685590"
    var tag = ""
    var thumbnail = "http"
    var title = "粤媒：艾克森存在感不强，他在国足面临与恒大相似的窘境　"
    var top_order = "0"
    var top_position = "2"
    var top_time = "0"
    var type = "zuqiu"
    var url = "/zuqiu/2019-10-11/5d9fcd4685590.htm"
    var version_url = "/zuqiu/2019-10-11/5d9fcd4685590_version2.htm"

    
    convenience init(json:JSON) {
        self.init()
        self.thumbnail = json["thumbnail"].stringValue
        self.title = json["title"].stringValue
        self.updatetime = json["updatetime"].stringValue
        self.url = json["url"].stringValue

    }
}

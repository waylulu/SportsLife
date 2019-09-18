//
//  HTRankModel.swift
//  SportsLife
//
//  Created by seven on 2019/8/28.
//  Copyright © 2019 west. All rights reserved.
//

import UIKit
import SwiftyJSON

class HTRankModel: NSObject {

    
    var 排名 = "1";
    var 球队  = "2";
    var icon = ""
    var 场次  = "2";
    var 胜  = "3";
    var 平  = "3";
    var 负  = "4";
    var 净失球  = "5";
    var 积分  = "7";
    var teamId = "";
    
    convenience init(json:JSON) {
        self.init()
        排名 = json["排名"].stringValue
        球队 = json["球队"].stringValue
        场次 = json["场次"].stringValue
        胜 = json["胜"].stringValue
        平 = json["平"].stringValue
        负 = json["负"].stringValue
        净失球 = json["进/失球"].stringValue
        积分  = json["积分"].stringValue
        icon = json["球队图标"].stringValue
        teamId = json["teamId"].stringValue
    }
}

var yingChaoRickoUrl = "http://dc.qiumibao.com/shuju/public/index.php?_url=/data/index&league=英超&tab=积分榜&year=2019"


///积分url
var HTRankUrl:(_ league:String,_ tab:String,_ year:String)->String = { league,tab,year in
    
    return HTurlString("http://dc.qiumibao.com/shuju/public/index.php?_url=/data/index&league=\(league)&tab=\(tab)&year=\(year)")

}
///规则url
var HTRuleWebUrl:( _ type:String)->String = { string in
    
    return HTurlString("http://dc.qiumibao.com/data/rule/words/\(string).php")   
}


class HTRankServices {
    
    
    func getNewsArr(league:String,tab:String,year:String, loadingView:UIView,callBack:@escaping (([HTRankModel],JSON)->())){
        HTServices.htNet.getData(loadingView: loadingView, urlString: HTRankUrl(league, tab, year), method: .get, parameters: [:]) {(json) -> (Void) in
            var arr = [HTRankModel]()
            
            var dic = [String:AnyObject]()
            for i in 0...json["items"].arrayValue.count {
                dic.updateValue(json["items"][i].stringValue as AnyObject, forKey: json["items"][i].stringValue)
            }
            let model = HTRankModel.init(json: JSON(dic))
            arr.append(model)
            
            if json["data"].arrayValue.count > 0{
                for js in json["data"].arrayValue {
                   arr.append(HTRankModel.init(json: js))
                }
                callBack(arr, json)
                
            }else{
                callBack([],json)
            }
            
        }
    }
    
    
    
}


let socre = "https://47.110.185.216/json/2019-09-17/373523.htm?device=iPhone11%2C8&time_zone=Asia/Shanghai&appname=zhibo8&os=iOS&UDID=f9842ff0c21fc7e2e86133bd99bbddb21f463206&platform=ios&pk=com.zhibo8.tenyears&_platform=ios&version_code=4.8.4&os_version=12.4.1&usersports=1&blacks_status=enable&IDFA=2D6BD8E3-DA38-46B3-A4C4-749EF4F500F0"

//
//  HTNewsDataViewModel.swift
//  SportsLife
//
//  Created by seven on 2019/8/26.
//  Copyright © 2019 west. All rights reserved.
//

import UIKit
import SwiftyJSON

//http://m.zhibo8.cc/json/news/zuqiu/2019_08_27-news-zuqiu-5d64e28c931dd ///2019_08_27-news-zuqiu-5d64e28c931dd
//let newsUrl = "http://m.zhibo8.cc/json/news/zuqiu_top.json"//yyyy-MM-dd

var newsUrl:(_ time:Double) ->String = { time in
    
    return "http://m.zhibo8.cc/json/news/zuqiu/\(currentTime(time ,"yyyy-MM-dd")).json?"
}


class HTNewsDataViewModel: NSObject {

    var newsModels = [newsDetailModel]()
    
    func getNewsArr(url:String ,loadingView:UIView,callBack:@escaping (([newsDetailModel],JSON)->())){
        HTServices.htNet.getData(loadingView: loadingView, urlString: url, method: .get, parameters: [:]) { (json) -> (Void) in
        
            print(json)
            if json["video_arr"].arrayValue.count > 0{
                for js in json["video_arr"].arrayValue {
                    if js["lable"].stringValue.contains("西甲"){
                        self.newsModels.append(newsDetailModel.init(json: js))
                    }
                }
                callBack((self.newsModels) , json)
                
            }else{
                callBack([],json)
            }
            
        }
    }
    
//    func getNewsArr(loadingView:UIView,callBack:@escaping (([HTNewsModel],JSON)->())){
//        HTServices.htNet.getData(loadingView: loadingView, urlString: newsUrl, method: .get, parameters: [:]) { (json) -> (Void) in
//
//            if json["toplist"].arrayValue.count > 0{
//                for js in json["toplist"].arrayValue {
//                    self.newsModels.append(HTNewsModel.init(json: js))
//                }
//                callBack(self.newsModels, json)
//
//            }else{
//                callBack([],json)
//            }
//
//        }
//    }
    
}

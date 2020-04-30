//
//  HTVideoModel.swift
//  SportsLife
//
//  Created by seven on 2019/9/3.
//  Copyright © 2019 west. All rights reserved.
//


//let 西甲 = "http://cdn.a8.tvesou.com/right/recommend_video_list?leagueId=6&pageSize=10&page=1"
//let 英超 = "http://cdn.a8.tvesou.com/right/recommend_video_list?leagueId=4&pageSize=10&page="
//let 德甲 = "http://cdn.a8.tvesou.com/right/recommend_video_list?leagueId=3&pageSize=10&page="
//let 意甲 = "http://cdn.a8.tvesou.com/right/recommend_video_list?leagueId=5&pageSize=10&page="
//let 法甲 = "http://cdn.a8.tvesou.com/right/recommend_video_list?leagueId=7&pageSize=10&page="
//let 欧冠 = "http://cdn.a8.tvesou.com/right/recommend_video_list?leagueId=8&pageSize=10&page="
//let 中超 = "http://cdn.a8.tvesou.com/right/recommend_video_list?leagueId=9&pageSize=10&page="

var videoUrl:(_ leagueId:String, _ page:String)->String = { league, page in
    return "http://cdn.a8.tvesou.com/right/recommend_video_list?leagueId=\(league)&pageSize=10&page=\(page)"
}



import UIKit
import SwiftyJSON

class HTVideoModel: NSObject {
    var title = ""
    var url = ""
    var image = ""
    
    
    convenience init(json:JSON) {
        self.init()
        self.title = json["title"].stringValue
        self.url = json["url"].stringValue
        self.image = json["image"].stringValue
    }
    
    
    


}

class HTVideoService {
    var videoModels = [HTVideoModel]()
    
    func getVideoArr(league:String,page:String , loadingView:UIView, callBack:@escaping (([HTVideoModel],JSON)->())){
        HTServices.htNet.getData(loadingView: loadingView, urlString: videoUrl(league, page), method: .get, parameters: [:]) {[weak self] (json) -> (Void) in
            
            print(json)
            if json["error_code"].intValue == 1{
                for js in json["data"].arrayValue {
                    self?.videoModels.append(HTVideoModel.init(json: js))
                }
                callBack((self?.videoModels)!, json)
                
            }else{
                callBack([],json)
            }
            
        }
    }
}

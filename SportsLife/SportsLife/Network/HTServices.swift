//
//  HTServices.swift
//  SportsLife
//
//  Created by seven on 2019/8/26.
//  Copyright © 2019 west. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

let OUGUANVIDEOURL = "http://cdn.a8.tvesou.com/right/recommend_video_list?leagueId=8&pageSize=10&page=1"

typealias AlamoFireAndSwiftyJSONCallBackData = (_ json:JSON)->(Void)
typealias AFNAndSwiftyJSONCallBackData = (_ json:JSON, _ error:Error)->(Void)

class HTServices: NSObject {

    static let htNet = HTServices();
    
    func getData(loadingView:UIView, urlString:String, method:HTTPMethod,parameters:Parameters ,completion:@escaping (AlamoFireAndSwiftyJSONCallBackData)) {
//        let mb = MBProgressHUD.showAdded(to: loadingView, animated: true)
//        mb.mode = .indeterminate
//        mb.label.text = ""
//        mb.hide(animated: true, afterDelay: 10)
        
        Alamofire.request(urlString, method: method, parameters: parameters).responseJSON { (data)  in
            DispatchQueue.main.async {
//                mb.hide(animated: true)
                let json = JSON.init(data.data ?? Data());
                completion(json)
            }
        }
        
    }
    
    func getAFNData(urlString:String, method:HTTPMethod,parameters:Parameters ,completion:@escaping (AFNAndSwiftyJSONCallBackData)) {
        let manager = AFHTTPSessionManager()
        manager.responseSerializer = AFHTTPResponseSerializer()
        let dic  = ["a":"1"]
        manager.get(urlString, parameters: dic, progress: { (pro) in
            
        }, success: { (task, res) in
    
            print(res)
        }) { (task, err) in
            
        }
    }
    
}

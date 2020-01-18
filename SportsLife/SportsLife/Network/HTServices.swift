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

//let OUGUANVIDEOURL = "http://cdn.a8.tvesou.com/right/recommend_video_list?leagueId=8&pageSize=10&page=1"

let parametersDic = [    "vcode":    "8274",
                         "ip"  :  "192.168.1.68",
    "version_code"  :  "4.8.3",
    "time"  :  "1567649205",
    "usersports" :   "1",
    "operator"  :  "46001",
    "ts"   : "1567649206",
    "opentype"  : "phone",
    "IDFA"   : "00000000-0000-0000-0000-000000000000",
    "vendor"  :  "Apple",
    "udid"  :  "f9842ff0c21fc7e2e86133bd99bbddb21f463206",
    "lan"  :  "zh-Hans-CN",
    "os"   : "iOS",
    "geo"  :  "113.947532,22.540005",
    "net"  :  "2",
    "appname"   : "zhibo8",
    "openudid"  :  "f9842ff0c21fc7e2e86133bd99bbddb21f463206",
    "orientation" :   "0",
    "phone_no"   : "13296697969",
    "UDID"    :"f9842ff0c21fc7e2e86133bd99bbddb21f463206",
    "_platform"   : "ios",
    "time_zone"   : "Asia/Shanghai",
    "os_version"  :  "12.4",
    "chk"   : "1c71d3faa5da2972b0e4be7fefa047c9",
    "pk"   : "com.zhibo8.tenyears",
    "density"  :  "359",
    "model"  :  "iPhone11,8",
    "zone_code"   : "+86",
    "device"   : "iPhone11,8",
    "blacks_status"  :  "disable"]

typealias AlamoFireAndSwiftyJSONCallBackData = (_ json:JSON)->(Void)
typealias AFNAndSwiftyJSONCallBackData = (_ json:JSON, _ error:Error)->(Void)

class HTServices: NSObject {

    static let htNet = HTServices();
    
    func getData(loadingView:UIView, urlString:String, method:HTTPMethod,parameters:Parameters ,completion:@escaping (AlamoFireAndSwiftyJSONCallBackData)) {
        let mb = MBProgressHUD.showAdded(to: loadingView, animated: true)
        mb.mode = .indeterminate
        mb.label.text = ""
        mb.hide(animated: true, afterDelay: 10)
        print(parameters)
        Alamofire.request(urlString, method: method, parameters: parameters).responseJSON { (data)  in
            DispatchQueue.main.async {
                mb.hide(animated: true)
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

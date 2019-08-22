//
//  HelperClass.swift
//  SportsLife
//
//  Created by seven on 2019/8/6.
//  Copyright © 2019 west. All rights reserved.
//

import UIKit

let WIDTH = UIScreen.main.bounds.size.width
let HEIGHT = UIScreen.main.bounds.size.height
//let sourceViewHeight:CGFloat = 400;
var cellHeight:CGFloat =  40;
let headerHeight:CGFloat = 40;
let btnWidth:CGFloat = 60;

let isIPhoneX = HEIGHT == 812 || HEIGHT == 896 ? true : false
let bottomHeight:CGFloat = isIPhoneX ? 34 : 0

let SegWidth:CGFloat = 120;

let naviHeight:CGFloat = isIPhoneX ? 88 : 64
///支付类型
enum PayType {
    case unionPay
    case aliPay
    case wewhatPay
    case defalut
}
///卡片数量
enum CradType {
    case one
    case more
    case notPay
    case defalut
}
///本地图片
var HTImage:(String) ->UIImage = { string in
    return UIImage.init(named: string) ?? UIImage()
}
//颜色RGB加透明度
var HTColor:(_ r:CGFloat,_ g:CGFloat,_ b:CGFloat,_ alpha:CGFloat)->UIColor = {r,g,b,a in
    
    return UIColor.init(red: r / 255.0, green: r / 255.0, blue: r / 255.0, alpha: a);
}

var HTHex:(_ hex:String,_ alpha:CGFloat)->UIColor = {hex,alpha in
    
    var rgb : UInt32 = 0
    
    let scanner = Scanner(string: hex)
    
    if hex.hasPrefix("#") { // 跳过“#”号
        scanner.scanLocation = 1
    }
    
    scanner.scanHexInt32(&rgb)
    
    let r = CGFloat((rgb & 0xff0000) >> 16) / 255.0
    let g = CGFloat((rgb & 0xff00) >> 8) / 255.0
    let b = CGFloat(rgb & 0xff) / 255.0
    
    return UIColor(red: r, green: g, blue: b, alpha: alpha)

}

class HelperClass {
 
    static let shared = HelperClass()


  
}

///数据处理
extension HelperClass{
    
    ///数组转JSON
    func arrayToJson(_ array:AnyObject)->String{
        
        //首先判断能不能转换
        if (!JSONSerialization.isValidJSONObject(array)) {
            //print("is not a valid json object")
            return ""
        }
        
        //利用OC的json库转换成OC的NSData，
        //如果设置options为NSJSONWritingOptions.PrettyPrinted，则打印格式更好阅读
        let data : Data = try! JSONSerialization.data(withJSONObject: array, options: .prettyPrinted)
        //NSData转换成NSString打印输出
        let str = String(data: data, encoding: .utf8)
        //输出json字符串
        return str as String? ?? ""
    }
    
    
    ///数组(里面类型为字典)转字符串
    func dicArrayToJson(_ dicArray:[[String:AnyObject]])->String{
        
        //首先判断能不能转换
        if (!JSONSerialization.isValidJSONObject(dicArray)) {
            //print("is not a valid json object")
            return ""
        }
        
        //利用OC的json库转换成OC的NSData，
        //如果设置options为NSJSONWritingOptions.PrettyPrinted，则打印格式更好阅读
        let data : Data! = try? JSONSerialization.data(withJSONObject: dicArray, options: .prettyPrinted)
        //NSData转换成NSString打印输出
        guard let str = String(data: data, encoding: .utf8) else { return "" }
        //输出json字符串
        return str
    }
    
    /** json 字符串字典*/
    func jsonToObject(jsonString:String)->Dictionary<String,AnyObject>{
        
        let dic = Dictionary<String,AnyObject>()
        
        
        do{
            
            let data = jsonString.data(using: String.Encoding.utf8)!
            //把NSData对象转换回JSON对象
            let json :Any! = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.mutableContainers)
            
            return json as! Dictionary<String, AnyObject>
        }catch{
            return dic
        }
        
        
        
    }
    
    /** json 字符串数组*/
    func jsonToArray(jsonString:String)->Array<Dictionary<String, AnyObject>>{
        
        let arr = [Dictionary<String,AnyObject>()]
        
        do{
            
            let data = jsonString.data(using: String.Encoding.utf8)!
            //把NSData对象转换回JSON对象
            let json : Any! = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.mutableContainers)
            
            return json as! [Dictionary<String, AnyObject>]
        }catch{
            return arr
        }
        
    }
}


extension UIImageView{
    ///网络图片
   public func HTdownloadedFrom(imageurl : String){
        if imageurl.isEmpty {
            return
        }
        let newUrl = imageurl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        //创建URL对象
        let url = URL(string: newUrl!)!
        //创建请求对象
        let request = URLRequest(url: url)
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request, completionHandler: {
            (data, response, error) -> Void in
            if error != nil{
                print(error.debugDescription)
            }else{
                //将图片数据赋予UIImage
                let img = UIImage(data:data!)
                
                // 这里需要改UI，需要回到主线程
                DispatchQueue.main.async {
                    self.image = img
                }
                
            }
        }) as URLSessionTask
        
        //使用resume方法启动任务
        dataTask.resume()
    }
    func HTdowloadFromServer(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func HTdowloadFromServer(link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        HTdowloadFromServer(url: url, contentMode: mode)
    }
    
}
extension UIColor{
    
    
    /** 16进制颜色表示 */
    func colorWithHex(hex: String, alpha: CGFloat = 1.0) -> UIColor {
        
        var rgb : UInt32 = 0
        
        let scanner = Scanner(string: hex)
        
        if hex.hasPrefix("#") { // 跳过“#”号
            scanner.scanLocation = 1
        }
        
        scanner.scanHexInt32(&rgb)
        
        let r = CGFloat((rgb & 0xff0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0xff00) >> 8) / 255.0
        let b = CGFloat(rgb & 0xff) / 255.0
        
        return UIColor(red: r, green: g, blue: b, alpha: alpha)
    }

}

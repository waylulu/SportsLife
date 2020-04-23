//
//  HelperClass.swift
//  SportsLife
//
//  Created by seven on 2019/8/6.
//  Copyright © 2019 west. All rights reserved.
//

import UIKit
///宽
let WIDTH = UIScreen.main.bounds.size.width
///高
let HEIGHT = UIScreen.main.bounds.size.height
//let sourceViewHeight:CGFloat = 400;
var cellHeight:CGFloat =  40;
let headerHeight:CGFloat = 40;
let btnWidth:CGFloat = 60;

///是否是刘海屏
let isIPhoneX = HEIGHT == 812 || HEIGHT == 896 ? true : false

let bottomHeight:CGFloat = isIPhoneX ? 34 : 0

//导航栏高度
let naviHeight:CGFloat = isIPhoneX ? 88 : 64


let SegWidth:CGFloat = 60;


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

///url转义中文
var HTUrlString:(_ string:String)->String = { str in
    return str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
}


///设置label文字和图片共存
var HTGetAttributedText:(_ string:String,_ font:UIFont,_ image:UIImage)->NSAttributedString = { string,font,image  in
    
    let attri = NSMutableAttributedString.init(string: "  \(string)", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13)])
    let attachment = NSTextAttachment.init()
    attachment.image = image
    attachment.bounds = CGRect(x: 0, y: -4, width: 17, height: 17)
    attri.insert(NSAttributedString.init(attachment: attachment), at: 0)
    
    return attri
    
}


class HelperClass {
 
    static let shared = HelperClass()


//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    //设置格式
//    formatter.dateFormat = @"yyyy-MM-dd";
//    //获取当前系统时间
//    //    NSDate *date = [NSDate date];
//    NSDate *date1 = [NSDate   dateWithTimeIntervalSinceNow:page * TIME_MORE];
//    //把时间对象转换成字符串对象
//    NSString *dateString = [formatter  stringFromDate:date1];
//    NSString * url = [NSString stringWithFormat:@"http://m.zhibo8.cc/json/news/zuqiu/%@.json?",dateString];
    
    func  getTime()->String{
        let formatter = DateFormatter.init()
        formatter.dateFormat = "yyyy-MM-dd";
        return ""
    }

    func requestUrl(urlString: String,c:(@escaping(_ isRes:Bool)-> Void))  {
        let url: NSURL = NSURL(string: urlString)!
        var request: URLRequest = URLRequest(url: url as URL)
        request.timeoutInterval = 5

        var response: URLResponse?

        URLSession.shared.dataTask(with: request) { (data, res, err) in
            if let httpRes = res as? HTTPURLResponse{
                if httpRes.statusCode == 200 {
                    print(httpRes);
                    c(true)
                }
                c(false)
            }
            c(false)
        }
            
//    func requestUrl(urlString: String) -> Bool {
//        let url: NSURL = NSURL(string: urlString)!
//        var request: URLRequest = URLRequest(url: url as URL)
//        request.timeoutInterval = 5
//
//        var response: URLResponse?
//
//        URLSession.shared.dataTask(with: request) { (data, res, err) in
//            if let httpRes = res as? HTTPURLResponse{
//                if httpRes.statusCode == 200 {
//                    print(httpRes);
//                    return true;
//                }
//            }
//        }
//        do {
//            try NSURLConnection.sendSynchronousRequest(request as URLRequest, returning: &response)
//            if let httpResponse = response as? HTTPURLResponse {
//                if httpResponse.statusCode == 200 {
//                    print("response:\(httpResponse.statusCode)")
//                    return true
//                }
//            }
//            return false
//        }
//        catch (let error) {
//            print("error:\(error)")
//            return false
//        }
    }
    
    

}

var TIME_MORE:Double = (-8 * 60 * 60);


var currentTime:(_ time:Double ,_ formatterSample:String)->String = { time ,str in
    let formatter = DateFormatter.init()
    formatter.dateFormat = str;
    let date = Date.init(timeIntervalSinceNow: time)
    
    return formatter.string(from: date)
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

//    MARK:# 其他

class AlertView {
    
    static let shard = AlertView()
    
    //MARK: - 纯文字吐司
    public func MBProgressHUDWithMessage(view:UIView ,message: String) {
        DispatchQueue.main.async {
            let mb = MBProgressHUD.showAdded(to:view, animated: true)
            mb.mode = .text
            mb.label.textColor = UIColor.gray
            mb.label.text = message
            mb.hide(animated:true, afterDelay: 2)
            
        }
        
    }

    
    public func alertWithTitle(controller:UIViewController ,title:String, bloack:@escaping ()->()){
        
        let alert = UIAlertController.init(title: "", message: title, preferredStyle: .alert)
//        let attri = NSMutableAttributedString.init(string: title)
//        attri.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 18), range: NSMakeRange(0, title.count))
//        attri.setValue(attri, forKey: "attributedDetailMessage")
        
        controller.present(alert, animated: true, completion: {
            sleep(1)
            alert.dismiss(animated: true, completion: {
                bloack()
            })
        })
    }
    
    
    func  alertDetail(controller:UIViewController ,title:String, bloack:@escaping ()->()){
        let alert = UIAlertController.init(title: "", message: title, preferredStyle: .alert)

        let ok = UIAlertAction.init(title: "确定", style: UIAlertAction.Style.default) { (a) in

            alert.dismiss(animated: true, completion: {
                bloack()
            })
        }
        
        if #available(iOS 11.0, *) {
            let attri = NSMutableAttributedString.init(string: title)
            attri.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 10), range: NSMakeRange(0, title.count))
            attri.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.cyan, range: NSMakeRange(0, title.count))
            ok.accessibilityAttributedValue = attri;
        } else {
        }
        
        alert.addAction(ok);
        controller.present(alert, animated: true, completion: {
          
        })
    }

}
/**
 //批量替换字符串
 var str = "121412132515125213123134125"
 let old = ["12","13"]
 let new = ["aa","bb"]
 */
var HTrep:(_ str:String,_ old:[String],_ new:[String])->String = { str,old,new in
    
    var string = str
    for i in 0..<old.count {
        string = string.replacingOccurrences(of: old[i], with: new[i])
    }
    
    return string
}


extension String{
    func chineseToPinYin()->String{
        let mutableString = NSMutableString(string: self)
        CFStringTransform(mutableString, nil, kCFStringTransformToLatin, false)
        CFStringTransform(mutableString, nil, kCFStringTransformStripDiacritics, false)
        let string = String(mutableString)
        return string.replacingOccurrences(of: " ", with: "")
    }
}


extension String {
    
    func heightWithFont(font : UIFont, maxSize: CGSize) -> CGSize {
        let attrs = [NSAttributedString.Key.font: font]
        let rect = self.boundingRect(with: maxSize, options:.usesLineFragmentOrigin, attributes: attrs, context:nil)
        return rect.size
    }
    
    func stringToUrl() ->URL{
        
        return URL.init(string: self)!
    }
    
}



///对Data类型进行扩展
extension Data {
    //将Data转换为String
    var hexString: String {
        return withUnsafeBytes {(bytes: UnsafePointer<UInt8>) -> String in
            let buffer = UnsafeBufferPointer(start: bytes, count: count)
            return buffer.map {String(format: "%02hhx", $0)}.reduce("", { $0 + $1 })
        }
        
    }
    
    
    var deviceTokenString : String {
        var str = "";
        let bytes = [UInt8](self)
        for item in bytes {
            str += String(format:"%02x", item&0x000000FF)
        }
        return str;
    }
    
    
}


var deviceTokenDataToString:(_ data:Data)->String = { data in
    var str = "";
    let bytes = [UInt8](data)
    for item in bytes {
        str += String(format:"%02x", item&0x000000FF)
    }
    return str;

}

extension UIButton{
    
}

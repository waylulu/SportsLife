//
//  HTColors.swift
//  SportsLife
//
//  Created by seven on 2019/8/26.
//  Copyright © 2019 west. All rights reserved.
//

import UIKit


//颜色RGB加透明度
var HTColor:(_ r:CGFloat,_ g:CGFloat,_ b:CGFloat,_ alpha:CGFloat)->UIColor = {r,g,b,a in
    
    return UIColor.init(red: r / 255.0, green: r / 255.0, blue: r / 255.0, alpha: a);
}

///二进制色值处理
var HTHexColor:(_ hex:String,_ alpha:CGFloat)->UIColor = {hex,alpha in
    
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
let drakTextColor = HTColor(111, 111, 111, 1)
let drakViewColor = HTColor(111, 111, 111, 1)
let drakBtnColor = HTColor(111, 111, 111, 1)
let drakNavTitleColor = HTColor(111, 111, 111, 1)
let drakTabarTitleColor = HTColor(111, 111, 111, 1)


let lightTextColor = HTColor(111, 111, 111, 1)
let lightViewColor = HTColor(111, 111, 111, 1)
let lightBtnColor = HTColor(111, 111, 111, 1)
let lightNavTitleColor = HTColor(111, 111, 111, 1)
let lightTabarTitleColor = HTColor(111, 111, 111, 1)


class HTColors: NSObject {

}
extension UIColor {
    // 在extension中给系统的类扩充构造函数,只能扩充`便利构造函数`
    convenience init(r : CGFloat, g : CGFloat, b : CGFloat, alpha : CGFloat = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
    
    /// 灰色
    ///
    /// - Parameter gray:
    convenience init(gray: CGFloat) {
        self.init(red: gray / 255.0, green: gray / 255.0, blue: gray / 255.0, alpha: 1)
    }
    
    convenience init?(hex : String, alpha : CGFloat = 1.0) {
        
        // 0xff0000
        // 1.判断字符串的长度是否符合
        guard hex.count >= 6 else {
            return nil
        }
        
        // 2.将字符串转成大写
        var tempHex = hex.uppercased()
        
        // 3.判断开头: 0x/#/##
        if tempHex.hasPrefix("0x") || tempHex.hasPrefix("##") {
            tempHex = (tempHex as NSString).substring(from: 2)
        }
        if tempHex.hasPrefix("#") {
            tempHex = (tempHex as NSString).substring(from: 1)
        }
        
        // 4.分别取出RGB
        // FF --> 255
        var range = NSRange(location: 0, length: 2)
        let rHex = (tempHex as NSString).substring(with: range)
        range.location = 2
        let gHex = (tempHex as NSString).substring(with: range)
        range.location = 4
        let bHex = (tempHex as NSString).substring(with: range)
        
        // 5.将十六进制转成数字 emoji表情
        var r : UInt32 = 0, g : UInt32 = 0, b : UInt32 = 0
        Scanner(string: rHex).scanHexInt32(&r)
        Scanner(string: gHex).scanHexInt32(&g)
        Scanner(string: bHex).scanHexInt32(&b)
        
        self.init(r : CGFloat(r), g : CGFloat(g), b : CGFloat(b))
    }
    
    
    class func randomColor() -> UIColor {
        return UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
    }
    
    
    class func getRGBDelta(_ firstColor : UIColor, _ seccondColor : UIColor) -> (CGFloat, CGFloat,  CGFloat) {
        let firstRGB = firstColor.getRGB()
        let secondRGB = seccondColor.getRGB()
        
        return (firstRGB.0 - secondRGB.0, firstRGB.1 - secondRGB.1, firstRGB.2 - secondRGB.2)
    }
    
    
    func getRGB() -> (CGFloat, CGFloat, CGFloat) {
        guard let cmps = cgColor.components else {
            fatalError("保证普通颜色是RGB方式传入")
        }
        
        return (cmps[0] * 255, cmps[1] * 255, cmps[2] * 255)
    }
    
    //底部按钮颜色
    public func BottomButtonColor() -> UIColor{
        
        return UIColor.init(red: 192/255.0, green: 25/255.0, blue: 35/255.0, alpha: 1.0)
        
    }
   
    //背景色
    final class var bgColor : UIColor {
        return UIColor.colorWithHex(hex: "EFEFEF", alpha: 1)
    }
 
    /** 文字灰色 */
    final class var TextGray : UIColor {
        return UIColor.init(red: 180/255.0, green: 180/255.0, blue: 180/255.0, alpha: 1.0)
    }
    
    /** 主题颜色(白色) */
    final class var themeColor : UIColor {
        return UIColor.colorWithHex(hex: "ffffff", alpha: 1)
    }
    
    /** 主色调 */
    final class var defaultColor : UIColor {
        return UIColor.colorWithHex(hex: "#FF5655", alpha: 1)
    }
    final class var sexLineColor : UIColor {
        return UIColor.colorWithHex(hex: "D8D8D8", alpha: 1)
    }
    
    /** 16进制颜色表示 */
    class func colorWithHex(hex: String, alpha: CGFloat = 1.0) -> UIColor {
        
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

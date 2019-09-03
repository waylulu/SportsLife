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

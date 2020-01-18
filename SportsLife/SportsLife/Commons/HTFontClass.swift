//
//  HTFontClass.swift
//  SportsLife
//
//  Created by seven on 2020/1/17.
//  Copyright © 2020 west. All rights reserved.
//

import UIKit

class HTFontClass: NSObject {

}


let HTdefalutFont = UIFont.systemFont(ofSize: 12);


///size:字体大小 font:字体样式""为默认
let HTFont:(_:CGFloat,_:String)->UIFont = { size,style in
    
    return (style == "" ? UIFont.systemFont(ofSize: size) : UIFont.init(name: style, size: size)) ?? HTdefalutFont
    
}
///字体"PingFangSC-Medium"
var HTFontMedium:(CGFloat) ->UIFont = { f in
    return UIFont.init(name: "PingFangSC-Medium", size: f) ?? HTdefalutFont
}
///字体"PingFangSC-Regular"
var HTFontRegular:(CGFloat) ->UIFont = { f->UIFont in
    return UIFont.init(name: "PingFangSC-Regular", size: f) ?? HTdefalutFont
}


///字体"PingFangSC-Semibold"
var HTFontSemibold:(CGFloat) ->UIFont = { f in
    return UIFont.init(name: "PingFangSC-Semibold", size: f) ?? HTdefalutFont
}

///字体"PingFangSC-Medium"
var HTFontHelvetica:(CGFloat) ->UIFont = { f in
    return UIFont.init(name: "Helvetica", size: f) ?? HTdefalutFont
}


var HTCostomFont:(CGFloat)->UIFont = { f in
    return UIFont.systemFont(ofSize: f);
}

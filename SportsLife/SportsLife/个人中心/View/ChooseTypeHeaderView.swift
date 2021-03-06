//
//  ChooseTypeHeaderView.swift
//  SportsLife
//
//  Created by seven on 2019/8/5.
//  Copyright © 2019 west. All rights reserved.
//

let BGColor = UIColor.init(red: 244 / 255, green: 244 / 255, blue: 244 / 255, alpha: 1)

var color : (red:CGFloat,green:CGFloat,blue:CGFloat,alpha:CGFloat)?


let colorRGB = UIColor.init(red:color!.red , green: color!.green, blue: color!.blue, alpha: color!.alpha) //(red:CGFloat,green:CGFloat,blue:CGFloat).self

import UIKit
import Masonry

typealias cancelBtnBlock = (_ title:String)->()
typealias confirmBtnBlock = (_ title:String)->()

@objcMembers
class ChooseTypeHeaderView: UIView {

    var leftBtn = UIButton()
    var centerTitleLabel = UILabel()
    var rightBtn = UIButton()
    var leftBtnTitle = ""
    var centerTitle = ""
    var rightBtnTitle = ""
    var confirmClick :confirmBtnBlock?
    var cancalClick:cancelBtnBlock?
    
    convenience init(frame:CGRect,leftBtnTitle:String,centerTitle:String,rightBtnTitle:String) {
        self.init(frame: frame)
        self.leftBtnTitle = leftBtnTitle
        self.centerTitle = centerTitle
        self.rightBtnTitle = rightBtnTitle
        self.configUI()

    }

    func configUI(){
        self.backgroundColor = BGColor
        
        self.leftBtnUI()
        self.centerTitleLabelUI()
        self.rightBtnUI()
    }
    
    
    func leftBtnUI(){
        leftBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: btnWidth, height: self.frame.height))
        self.addSubview(leftBtn)
        leftBtn.setTitle(leftBtnTitle, for: UIControl.State.normal)
        leftBtn.setTitleColor(UIColor.gray, for: UIControl.State.normal)
        leftBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        leftBtn.addTarget(self, action: #selector(cancelBtnClick(sender:)), for: UIControl.Event.touchUpInside)
    }
    
    func centerTitleLabelUI(){
        centerTitleLabel = UILabel.init(frame: CGRect(x: btnWidth, y: 0, width: WIDTH - 120, height: self.frame.height))
        self.addSubview(centerTitleLabel)
        centerTitleLabel.textAlignment = .center
        centerTitleLabel.text = centerTitle;
        centerTitleLabel.font = UIFont.systemFont(ofSize: 13)

    }
    
    func rightBtnUI(){
        rightBtn = UIButton.init(frame: CGRect(x: WIDTH - btnWidth, y: 0, width: btnWidth, height: self.frame.height))
        self.addSubview(rightBtn)
        rightBtn.setTitle(rightBtnTitle, for: UIControl.State.normal)
        rightBtn.setTitleColor(UIColor.black, for: UIControl.State.normal)
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        rightBtn.addTarget(self, action: #selector(confirmBtnClick(sender:)), for: UIControl.Event.touchUpInside)

    }
    
    func cancelBtnClick(sender:UIButton){
        if (self.cancalClick != nil) {
            self.cancalClick!(sender.currentTitle ?? "")
        }
    }
    
    func confirmBtnClick(sender:UIButton){
        if (self.confirmClick != nil) {
            self.confirmClick!(sender.currentTitle ?? "")
        }
    }
}

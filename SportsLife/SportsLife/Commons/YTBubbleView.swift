//
//  YTBubbleView.swift
//  club
//
//  Created by wheng on 2017/11/8.
//  Copyright © 2017年 admin. All rights reserved.
//

import UIKit

// 尺寸
let scaleWidth = WIDTH / 720
// 尺寸
let scaleHeight = HEIGHT / 1280

let keyWindow = UIApplication.shared.keyWindow!

let textArr = ["2015","2016","2017","2018","2019"]


class YTBubbleView: UIView {

    //角高
    let angleH: CGFloat = 15 * scaleWidth
    //圆角
    let radius: CGFloat = 10 * scaleWidth
    //角起始位置X
    let angleXS: CGFloat = 235 * scaleWidth
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    let imgArr = ["ic-tianjia","ic-chazhao","ic-saoyisao","ic-qunzu"]
    
    typealias clickBlock = (String)->()
    var popItemAction: clickBlock?
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addItems()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addItems() {
        for i in 0..<imgArr.count {
            let item = YTItemButton.init(img: UIImage.init(named: imgArr[i]), title: textArr[i])
            self.addSubview(item)
            item.mas_makeConstraints { (make) in
                make?.top.equalTo()((15 + CGFloat(i) * 65) * scaleHeight)
                make?.height.equalTo()(65 * scaleHeight)
                make?.width.equalTo()(204 * scaleWidth)
                make?.centerX.equalTo()
            }
            

            item.tag = 500 + i
            item.addTarget(self, action: #selector(itemButtonAction(_:)), for: .touchUpInside)
        }
    }
    
    //选择回调
    @objc func itemButtonAction(_ sender: YTItemButton) {
        if let action = self.popItemAction {
            action(sender.label.text ?? "")
        }
    }
    
    override func draw(_ rect: CGRect) {
    
        
        if let context = UIGraphicsGetCurrentContext() {
            drawInContext(context: context)
        }
    }

    @objc func drawInContext(context: CGContext) {
    
        context.setLineWidth(1.0)
        context.setFillColor(UIColor.white.cgColor)
        drawPath(context: context)
        context.fillPath()

    }
    
    @objc func drawPath(context: CGContext) {
       
        let maxX = self.bounds.size.width
        let maxY = self.bounds.size.height
        let minX = self.bounds.origin.x
        let minY = self.bounds.origin.y + angleH
        
        context.move(to: CGPoint.init(x: angleXS, y: minY))
        
        context.addLine(to: CGPoint.init(x: angleXS + angleH, y: minY - angleH))
        context.addLine(to: CGPoint.init(x: angleXS + angleH * 2, y: minY))
        
        //四个圆角
        context.addArc(tangent1End: CGPoint.init(x: maxX, y: minY), tangent2End: CGPoint.init(x: maxX, y: maxY), radius: radius)
        context.addArc(tangent1End: CGPoint.init(x: maxX, y: maxY), tangent2End: CGPoint.init(x: minX, y: maxY), radius: radius)
        context.addArc(tangent1End: CGPoint.init(x: minX, y: maxY), tangent2End: CGPoint.init(x: minX, y: minY), radius: radius)
        context.addArc(tangent1End: CGPoint.init(x: minX, y: minY), tangent2End: CGPoint.init(x: maxX, y: minY), radius: radius)
        context.closePath()
    }
}

class YTItemButton: UIButton {
    
    var imgView = UIImageView()
    var label = UILabel()
    var line = UIView()
    
    convenience init(img: UIImage?, title: String?) {
        self.init(frame: CGRect.zero, img: img, title: title)
    }
    
    init(frame: CGRect, img: UIImage?, title: String?) {
        super.init(frame: frame)
        addSubViews()
        setFrame()
        addAttribute()
        imgView.image = img
        label.text = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubViews() {
        self.addSubview(imgView)
        self.addSubview(label)
        self.addSubview(line)
    }
    
    func setFrame() {
//        imgView.mas_makeConstraints({ (make) in
//            make?.left.centerY()?.equalTo()
//            make?.width.equalTo()(36 * scaleWidth)
//            make?.height.equalTo()(33 * scaleHeight)
//        })
        
        label.mas_makeConstraints { (make) in
            make?.left.equalTo()//(36 * scaleWidth + 20)
            make?.top.bottom().equalTo()
            make?.width.equalTo()(80)
        }
        
        line.mas_makeConstraints {[weak self] (make) in
            make?.height.equalTo()(1)
            make?.left.right()?.equalTo()
            make?.top.equalTo()(self?.label.mas_bottom)
        }

    }
    
    func addAttribute() {
        imgView.contentMode = .scaleAspectFill
        label.font = UIFont.systemFont(ofSize: 30 * scaleWidth)
        label.textColor = UIColor.black
        line.backgroundColor = UIColor.gray
    }
}

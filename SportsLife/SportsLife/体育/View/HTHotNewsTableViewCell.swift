//
//  HTHotNewsTableViewCell.swift
//  SportsLife
//
//  Created by seven on 2019/8/26.
//  Copyright © 2019 west. All rights reserved.
//

import UIKit
import SwiftyJSON

let hCellId = "hot"
let hotCellHeight:CGFloat = 80.0

class HTHotNewsTableViewCell: UITableViewCell {

    var headImageView = UIImageView()
    var titleLabel = UILabel()
    var sendTime = UILabel()
    var commentsLabel = UILabel()
    var playVideoImageView = UIImageView()
    var videoLengthLabel = UILabel()
    
//    var model = HTNewsModel()
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUI()
        self.layout()
//        self.setData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUI(){
        self.contentView.addSubview(headImageView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(sendTime)
        self.contentView.addSubview(commentsLabel)
        self.contentView.addSubview(playVideoImageView)
        self.contentView.addSubview(videoLengthLabel)
        
        self.backgroundColor = UIColor.init(rgba: arc4random() % 20)
        
        titleLabel.textColor = lightTextColor
        sendTime.textColor = lightTextColor
        commentsLabel.textColor = lightTextColor

        titleLabel.font = UIFont.systemFont(ofSize: 15)
        sendTime.font = UIFont.systemFont(ofSize: 13)
        
    }
    
    func layout(){
        headImageView.mas_makeConstraints { (make) in
            make?.top.leading()?.mas_equalTo()(10)
            make?.height.mas_equalTo()(hotCellHeight - 20)
            make?.width.mas_equalTo()(hotCellHeight)
        }
        
        titleLabel.mas_makeConstraints {[weak self] (make) in
            make?.top.mas_equalTo()(10)
            make?.leading.mas_equalTo()(self?.headImageView.mas_trailing)?.offset()(10)
            make?.trailing.mas_equalTo()(-10)
            make?.height.mas_equalTo()(40)
        }
        sendTime.mas_makeConstraints {[weak self]  (make) in
            make?.bottom.mas_equalTo()(-10)
            make?.leading.mas_equalTo()(self?.headImageView.mas_trailing)?.offset()(10)
            make?.height.mas_equalTo()(20)
        }
        commentsLabel.mas_makeConstraints { (make) in
            make?.trailing.mas_equalTo()(-10)
            make?.bottom.mas_equalTo()(-10)
            make?.height.mas_equalTo()(20)

        }
        
        playVideoImageView.snp.makeConstraints { (make) in
            make.center.equalTo(headImageView)
            make.width.height.equalTo(25)
        }
        
        videoLengthLabel.snp.makeConstraints { (make) in
            make.trailing.bottom.equalTo(headImageView)
            make.height.equalTo(20)
        }
    }
    
//    func setData(model:newsDetailModel){
//        headImageView.setImageWith(URL.init(string: model.thumbnail), placeholder: HTImage("default"))
//        titleLabel.text = model.title
//        titleLabel.numberOfLines = 2;
//        sendTime.text = model.updatetime
////        let attri = NSMutableAttributedString.init(string: "  12", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13)])
////        let attachment = NSTextAttachment.init()
////        attachment.image = HTImage("a")
////        attachment.bounds = CGRect(x: 0, y: -4, width: 17, height: 17)
////        attri.insert(NSAttributedString.init(attachment: attachment), at: 0)
//        commentsLabel.attributedText = HtgetAttributedText("12", defalutFont, HTImage("a"));
//    }
    
    
    
    func setNewsData(model:newsDetailModel){
        headImageView.setImageWith(URL.init(string: model.thumbnail), placeholder: HTImage("default"));
        titleLabel.text = model.title;
        titleLabel.numberOfLines = 2;
        sendTime.text = model.createtime
        
        HTServices.htNet.getData(loadingView: UIView(), urlString: pl(model.pinglun), method: .get, parameters: [:]) {[weak self](json) -> (Void) in
            
            self?.commentsLabel.attributedText = HTGetAttributedText(Comments.init(json: json).all_short_num, HTdefalutFont, HTImage("common"));
        }
        
        self.playVideoImageView.image = HTImage("play")
        self.videoLengthLabel.text = "01:23"
        self.videoLengthLabel.textAlignment = .center
        self.videoLengthLabel.backgroundColor = UIColor.black
        self.videoLengthLabel.alpha = 0.8
        self.videoLengthLabel.font = HTdefalutFont
        self.videoLengthLabel.textColor = UIColor.white
    }
    
}




//https://cache.zhibo8.cc/json/2019_10_11/news/zuqiu/5d9fd899ab085_count.json

var pl:(String)->String = { str in
    var url = str.replacingOccurrences(of: "-", with: "/")
    var urlStr = "https://cache.zhibo8.cc/json/" + "\(url)" + "_count.json"
    
    return urlStr
}

//
//  HTHotNewsTableViewCell.swift
//  SportsLife
//
//  Created by seven on 2019/8/26.
//  Copyright © 2019 west. All rights reserved.
//

import UIKit

let hCellId = "hot"
let hotCellHeight:CGFloat = 80.0

class HTHotNewsTableViewCell: UITableViewCell {

    var headImageView = UIImageView()
    var titleLabel = UILabel()
    var sendTime = UILabel()
    var commentsLabel = UILabel()
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
        
    }
    
    func setData(model:HTNewsModel){
        headImageView.setImageWith(URL.init(string: model.thumbnail), placeholder: HTImage("default"))
        titleLabel.text = model.title
        titleLabel.numberOfLines = 2;
        sendTime.text = model.updatetime
//        let attri = NSMutableAttributedString.init(string: "  12", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13)])
//        let attachment = NSTextAttachment.init()
//        attachment.image = HTImage("a")
//        attachment.bounds = CGRect(x: 0, y: -4, width: 17, height: 17)
//        attri.insert(NSAttributedString.init(attachment: attachment), at: 0)
        commentsLabel.attributedText = HtgetAttributedText("12", defalutFont, HTImage("a"));
    }
    
}


//
//  HTScheduleTableViewCell.swift
//  SportsLife
//
//  Created by seven on 2019/10/9.
//  Copyright © 2019 west. All rights reserved.
//

import UIKit
import Kingfisher

class HTScheduleTableViewCell: UITableViewCell {
    var dateLabel = UILabel()
    var homeItemLabel = UILabel()
    var homeItemImageView = UIImageView()
    var scoreLabel = UILabel()
    var awayItemImageView = UIImageView()
    var awayItemLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.layout()
        self.cellUI()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout(){
        self.contentView.addSubview(dateLabel)
        self.contentView.addSubview(homeItemLabel)
        self.contentView.addSubview(homeItemImageView)
        self.contentView.addSubview(scoreLabel)
        self.contentView.addSubview(awayItemImageView)
        self.contentView.addSubview(awayItemLabel)
        
        dateLabel.snp.makeConstraints { (make) in
            make.leading.top.bottom.equalTo(self)
            make.width.equalTo(80)
        }
        
        scoreLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.centerX.equalTo(self).offset(30)
            make.width.equalTo(40)
        }
        
        homeItemImageView.snp.makeConstraints { (make) in
            make.trailing.equalTo(scoreLabel.snp.leading).offset(-10)
            make.width.equalTo(25)
            make.height.equalTo(30)
            make.centerY.equalTo(self)
        }
        
        homeItemLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(homeItemImageView.snp.leading).offset(-10)
            make.leading.equalTo(dateLabel.snp.trailing)
            make.top.bottom.equalTo(self)
        }
        awayItemImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(scoreLabel.snp.trailing).offset(10)
            make.width.equalTo(25)
            make.height.equalTo(25)
            make.centerY.equalTo(self)
        }
        
        awayItemLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(awayItemImageView.snp.trailing).offset(10)
            make.width.equalTo(80)
            make.top.bottom.equalTo(self)
        }
    }
    
    func cellUI(){
//        dateLabel.text = "1242"
//        scoreLabel.text = "0-2"
//        homeItemImageView.image = HTImage("a")
//        homeItemLabel.text = "dsg"
//        awayItemImageView.image = HTImage("b")
//        awayItemLabel.text = "sahgsda"
        dateLabel.numberOfLines = 0;
        dateLabel.textAlignment = .center
        dateLabel.font = UIFont.systemFont(ofSize: 13)
        
        scoreLabel.textAlignment = .center;
        
        homeItemLabel.font = HTdefalutFont
        homeItemLabel.textAlignment = .right
        
        awayItemLabel.font = HTdefalutFont
    }
    
    func setData(model:schedeluitemData){
        dateLabel.text = model.date
        scoreLabel.text = model.score
        homeItemImageView.HTdownloadedFrom(imageurl: model.homeIcon)
        homeItemLabel.text = model.homwName
        awayItemImageView.HTdownloadedFrom(imageurl: model.awayIcon)
        awayItemLabel.text = model.awayName
    }
}

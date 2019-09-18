//
//  HTScoreTableViewCell.swift
//  SportsLife
//
//  Created by seven on 2019/9/17.
//  Copyright © 2019 west. All rights reserved.
//

import UIKit
import SnapKit
let scoreHeight:CGFloat = 60;

let sCell = "HTScoreTableViewCell"
class HTScoreTableViewCell: UITableViewCell {

    
    var collectionImage = UIImageView()
    var tabLabel = UILabel()
    var timeLabel = UILabel()
    var ballLabel = UILabel()
    var homeTeam = UILabel()
    var awayTeme = UILabel()
    var centerImageView = UIImageView()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configUI()
        self.layout()
        self.setData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI(){
        collectionImage = UIImageView.init()
        self.contentView.addSubview(collectionImage)
        tabLabel = UILabel.init()
        tabLabel.textAlignment = .right;
        tabLabel.font = defalutFont;
        self.contentView.addSubview(tabLabel)
        
        timeLabel = UILabel.init()
        timeLabel.textAlignment = .right;
        timeLabel.font = defalutFont;

        self.contentView.addSubview(timeLabel)
        
        ballLabel = UILabel.init()
        ballLabel.font = defalutFont;

        self.contentView.addSubview(ballLabel)
        
        homeTeam = UILabel.init()
        self.contentView.addSubview(homeTeam)
        homeTeam.font = defalutFont;

        awayTeme = UILabel.init()
        awayTeme.font = defalutFont;

        self.contentView.addSubview(awayTeme)
        centerImageView = UIImageView.init()
        self.contentView.addSubview(centerImageView)
    }
    
    func layout(){
        collectionImage.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.top.equalTo(15)
            make.bottom.equalTo(-15)
        }
        
        centerImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(30)
            make.height.equalTo(scoreHeight / 2)
            make.bottom.equalTo(self)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(centerImageView.snp.leading)
            make.height.equalTo(scoreHeight / 2)
            make.width.equalTo(scoreHeight)
            make.top.equalTo(self)
        }
        
        tabLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(timeLabel.snp.leading)
            make.height.equalTo(scoreHeight / 2)
            make.top.equalTo(self)
        }
        
        ballLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(centerImageView.snp.trailing)
            make.height.equalTo(scoreHeight / 2)
            make.top.equalTo(self)
        }
        
        homeTeam.snp.makeConstraints { (make) in
            make.trailing.equalTo(centerImageView.snp.leading)
            make.height.equalTo(scoreHeight / 2)
            make.bottom.equalTo(self)
        }
        
        awayTeme.snp.makeConstraints { (make) in
            make.leading.equalTo(centerImageView.snp.trailing)
            make.height.equalTo(scoreHeight / 2)
            make.bottom.equalTo(self)
        }
        
    }
    
    
    func setData(){
        collectionImage.image = HTImage("a")
        centerImageView.image = HTImage("b")
        timeLabel.text = "22:11"
        tabLabel.text = "西甲"
        ballLabel.text = "0.5/1.0"
        homeTeam.text = "巴萨"
        awayTeme.text = "皇马"
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

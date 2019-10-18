//
//  HTSquadTableViewCell.swift
//  SportsLife
//
//  Created by seven on 2019/9/30.
//  Copyright © 2019 west. All rights reserved.
//

import UIKit

class HTSquadTableViewCell: UITableViewCell {
    var iconImageView = UIImageView();
    var nameLabel = UILabel()
    var goalAndAssistLabel = UILabel()
    var numberLabel = UILabel()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.layout()
        self.configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func layout(){
        
        self.contentView.addSubview(iconImageView)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(goalAndAssistLabel)
        self.contentView.addSubview(numberLabel)
        
        iconImageView.snp.makeConstraints { (make) in
            make.width.equalTo(45)
            make.height.equalTo(50)
            make.leading.equalTo(15)
            make.centerY.equalTo(self)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconImageView.snp.top)
            make.leading.equalTo(iconImageView.snp.trailing).offset(10)
            make.height.equalTo(25)
        }
        goalAndAssistLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom)
            make.leading.equalTo(iconImageView.snp.trailing).offset(10)
            make.bottom.equalTo(iconImageView.snp.bottom)

        }
        
        numberLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.trailing.equalTo(-15)
        }
        
    }
    
    func configUI(){
        
//        iconImageView.image = HTImage("a")
//        nameLabel.text = "梅西"
//        goalAndAssistLabel.text = "进球:1 助攻: 4"
//        numberLabel.text = "10号"
        
        nameLabel.font = HTdefalutFont;
        goalAndAssistLabel.font = HTdefalutFont;
        numberLabel.font = HTFont(14,"");
    }
    
    
    func setPlayerData(model:playerTypeInfo){
        
        
        nameLabel.text = model.name
        iconImageView.HTdownloadedFrom(imageurl: model.avatar)
        goalAndAssistLabel.text = "进球:  " + model.goal + "  助攻:  " + model.assist
        
        let str = model.number + "号"
        let s = NSMutableAttributedString.init(string: model.number)
        s.addAttributes( [NSAttributedString.Key.font :HTFont(14,"")], range: NSRange.init(location: 0, length: str.count - 1))
        numberLabel.attributedText = s;
    }
    
    
    func setCoachData(model:coachInfo){
        
//        nameLabel.snp.updateConstraints { (make) in
//            make.height.equalTo(50)
//        }
//        goalAndAssistLabel.snp.makeConstraints { (make) in
//           make.height.equalTo(0)
//        }
        
        nameLabel.text = model.name
        iconImageView.HTdownloadedFrom(imageurl: model.avatar)
        numberLabel.text = model.position
        goalAndAssistLabel.text = "教练"

    }
    
}

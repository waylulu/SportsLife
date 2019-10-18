//
//  HTRankTableViewCell.swift
//  SportsLife
//
//  Created by seven on 2019/8/28.
//  Copyright © 2019 west. All rights reserved.
//

import UIKit
import SDWebImage

let HTdefalutWidth:CGFloat = WIDTH * (1 / 10 );
let HTdefalutFont = UIFont.systemFont(ofSize: 12);

class HTRankTableViewCell: UITableViewCell {
    
    var 排名: UILabel = UILabel()
    var 球队: UILabel = UILabel()
    var 场次: UILabel = UILabel()
    var 胜: UILabel = UILabel()
    var 平: UILabel = UILabel()
    var 负: UILabel = UILabel()
    var 净胜球: UILabel = UILabel()
    var 积分: UILabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configUI()
        self.layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func configUI(){
        self.contentView.addSubview( self.排名)
        self.contentView.addSubview( self.球队)
        self.contentView.addSubview( self.场次)
        self.contentView.addSubview( self.胜)
        self.contentView.addSubview( self.平)
        self.contentView.addSubview( self.负)
        self.contentView.addSubview( self.净胜球)
        self.contentView.addSubview( self.积分)
        self.initCell()
    }
    
    func initCell(){
        self.排名.textAlignment = .center
        self.排名.font = HTdefalutFont
        
//        self.球队.textAlignment = .center
        self.球队.font = HTdefalutFont

        self.场次.textAlignment = .center
        self.场次.font = HTdefalutFont

        self.胜.textAlignment = .center
        self.胜.font = HTdefalutFont

        self.平.textAlignment = .center
        self.平.font = HTdefalutFont

        self.负.textAlignment = .center
        self.负.font = HTdefalutFont

        self.净胜球.textAlignment = .center
        self.净胜球.font = HTdefalutFont

        self.积分.textAlignment = .center
        self.积分.font = HTdefalutFont

    }
    
    func layout(){
        self.排名.mas_makeConstraints { (make) in
//            make?.leading.equalTo()
            make?.leading.top()?.bottom()?.equalTo()
            make?.width.equalTo()(HTdefalutWidth)
        }
        
        self.球队.mas_makeConstraints {[weak self] (make) in
            make?.top.bottom()?.equalTo()
            make?.width.equalTo()(HTdefalutWidth * 2.5)
            make?.leading.equalTo()(self?.排名.mas_trailing)
        }
        self.场次.mas_makeConstraints {[weak self] (make) in
            make?.top.bottom()?.equalTo()
            make?.width.equalTo()(HTdefalutWidth)
            make?.leading.equalTo()(self?.球队.mas_trailing)
        }
        self.胜.mas_makeConstraints {[weak self] (make) in
            make?.top.bottom()?.equalTo()
            make?.width.equalTo()(HTdefalutWidth)
            make?.leading.equalTo()(self?.场次.mas_trailing)
        }
        self.平.mas_makeConstraints {[weak self] (make) in
            make?.top.bottom()?.equalTo()
            make?.width.equalTo()(HTdefalutWidth)
            make?.leading.equalTo()(self?.胜.mas_trailing)
        }
        self.负.mas_makeConstraints {[weak self] (make) in
            make?.top.bottom()?.equalTo()
            make?.width.equalTo()(HTdefalutWidth)
            make?.leading.equalTo()(self?.平.mas_trailing)
        }
        self.净胜球.mas_makeConstraints {[weak self] (make) in
            make?.top.bottom()?.equalTo()
            make?.width.equalTo()(HTdefalutWidth * 1.5)
            make?.leading.equalTo()(self?.负.mas_trailing)
        }
        self.积分.mas_makeConstraints {[weak self] (make) in
            make?.top.bottom()?.equalTo()
            make?.leading.equalTo()(self?.净胜球.mas_trailing)
            make?.trailing.equalTo()
        }
//
//
        
        
    }
    
    
    func setData(model:HTRankModel,index:Int){


//        if index == 0 {
            self.球队.text = model.球队
//        }else{
//            SDWebImageDownloader.shared.downloadImage(with: URL.init(string: model.icon), options: .continueInBackground, progress: nil) {[weak self] (image, data, err, true) in
//                self?.球队.attributedText  = HtgetAttributedText(model.球队, defalutFont, image ?? UIImage())
//            }
//        }
        self.球队.textAlignment = index == 0 ? .center :.left

        self.排名.text = model.排名;
        self.场次.text  = model.场次;
        self.胜 .text = model.胜;
        self.平.text  = model.平;
        self.负.text  = model.负;
        self.净胜球.text  = model.净失球;
        self.积分.text  = model.积分;
    }
    
}

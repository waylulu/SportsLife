//
//  ChooseTypeTableViewCell.swift
//  SportsLife
//
//  Created by seven on 2019/8/5.
//  Copyright © 2019 west. All rights reserved.
//

import UIKit

class ChooseTypeTableViewCell: UITableViewCell {

    var headerImageview = UIImageView()
    var titleLabel = UILabel()
    var detialLabel = UILabel()
    var chooseImageView = UIImageView()
    
    var model = CardsModel(){
        didSet {
            
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview()
        self.initCell()
        self.layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func addSubview(){
        self.contentView.addSubview(headerImageview)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(detialLabel)
        self.contentView.addSubview(chooseImageView)
    }
    
    func initCell(){
        titleLabel.font = UIFont.systemFont(ofSize: 12);
        detialLabel.font = UIFont.systemFont(ofSize: 12)
        chooseImageView.contentMode = .scaleToFill

    }

    func layout(){
        
        headerImageview.mas_makeConstraints { (make) in
            make?.left.equalTo()(20)
            make?.width.height()?.equalTo()(20)
            make?.centerY.equalTo()
        }
        
        titleLabel.mas_makeConstraints { (make) in
            make?.left.equalTo()(btnWidth)
            make?.top.bottom()?.equalTo()
            make?.width.equalTo()(200)
        }
        
        detialLabel.mas_makeConstraints { [weak self] (make) in
            make?.leading.equalTo()(self?.titleLabel.mas_trailing)
            make?.top.bottom()?.equalTo()
            make?.width.equalTo()(100)
        }
        chooseImageView.mas_makeConstraints { (make) in
            make?.trailing.equalTo()(-30)
            make?.height.width()?.equalTo()(20)
            make?.centerY.equalTo()
        }
    }
    
    func setData(type:CradType, model:CardsModel){
        if type == .one {
//            titleLabel.mas_updateConstraints { (make) in
//                make?.left.equalTo()(30)
//            }
            detialLabel.isHidden = true
        }
        titleLabel.text = model.title;
        detialLabel.text = model.detail
        titleLabel.backgroundColor = HTHexColor("FFEEFF", 1.0)
        self.headerImageview.image = type == .one ? HTImage(model.titleImage) : UIImage()
        self.headerImageview.contentMode = .scaleToFill
//        self.headerImageview.downloadedFrom(imageurl: "https://upload.jianshu.io/users/upload_avatars/1862499/0262d4cb861b?imageMogr2/auto-orient/strip|imageView2/1/w/120/h/120")
        chooseImageView.image = model.isChoose == true ?  UIImage.init(named:"choose") : UIImage()
    }
    
   
  
}



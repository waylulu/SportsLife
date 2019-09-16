//
//  HTVideoTableViewCell.swift
//  SportsLife
//
//  Created by seven on 2019/9/3.
//  Copyright © 2019 west. All rights reserved.
//

import UIKit

@objcMembers
class HTVideoTableViewCell: UITableViewCell {
    
    var headImageView = UIImageView()
    var titleLabel = UILabel()
    var palyBtn = UIButton()
    typealias btnClickCallback = ()->()
    
    var btnClick:btnClickCallback?
    
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUI(){
        self.contentView.addSubview(headImageView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(palyBtn)
        palyBtn.setImage(HTImage("play"), for: .normal)
        palyBtn.addTarget(self, action: #selector(playClick), for: .touchUpInside)
        
        self.backgroundColor = UIColor.init(rgba: arc4random() % 20)
        
        titleLabel.textColor = UIColor.gray
        
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        
    }
    
    func layout(){
        headImageView.mas_makeConstraints { (make) in
            make?.top.mas_equalTo()
            make?.left.right()?.mas_equalTo()
            make?.bottom.mas_equalTo()(-30)
        }
        
        palyBtn.mas_makeConstraints { [weak self] (make) in
            make?.width.height()?.mas_equalTo()(40)
            make?.center.mas_equalTo()(self?.headImageView)
        }
        titleLabel.mas_makeConstraints { (make) in
            make?.bottom.mas_equalTo()
            make?.leading.mas_equalTo()(10)
            make?.trailing.mas_equalTo()(-10)
            make?.height.mas_equalTo()(30)
        }

    }
    
    func setData(model:HTVideoModel){
        headImageView.setImageWith(URL.init(string: model.image), placeholder: HTImage("default"))
        titleLabel.text = model.title
        titleLabel.numberOfLines = 1;

    }
    
    func playClick(){
        if self.btnClick != nil{
            self.btnClick!()
        }
    }
    
}

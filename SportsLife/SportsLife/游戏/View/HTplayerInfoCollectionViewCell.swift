//
//  HTplayerInfoCollectionViewCell.swift
//  SportsLife
//
//  Created by seven on 2019/9/24.
//  Copyright © 2019 west. All rights reserved.
//

import UIKit

let playerDataCellWidth:CGFloat = (WIDTH - 5 * 6) / 5 ;
let playerDataCellHeight:CGFloat = 120;

class HTplayerInfoCollectionViewCell: UICollectionViewCell {
    
    let playerIcon = UIImageView()
    let playerName = UILabel()
    let playerdata = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layout()
//        self.loadData()
        self.configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func layout(){
        self.contentView.addSubview(playerIcon)
        self.contentView.addSubview(playerName)
        self.contentView.addSubview(playerdata)
        
        playerIcon.snp.makeConstraints { (make) in
        
            make.top.equalTo(10)
            make.centerX.equalTo(self)
            make.width.equalTo(playerDataCellWidth * 2 / 3)
            make.height.equalTo(playerDataCellHeight * 2 / 5)

        }
        
        playerName.snp.makeConstraints { (make) in
            make.top.equalTo(playerDataCellHeight / 2)
            make.height.equalTo(playerDataCellHeight / 4)
            make.width.equalTo(self)
            make.centerX.equalTo(self)
        }
        
        
        playerdata.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalTo(self)
            make.height.equalTo(playerDataCellHeight / 4)
        }
    }
    
    func configUI(){
    
        self.backgroundColor = UIColor.white
        self.playerName.textAlignment = .center
        self.playerdata.textAlignment = .center
        self.playerName.font = HTFont(12, "")
        self.playerdata.font = HTFont(12, "")
        self.playerName.numberOfLines = 0

    }
    
    func loadData(model:playerDetailModel){
        
        playerIcon.setImageWith(URL.init(string: model.avatar), placeholder: HTImage("a"))
        playerName.text = model.player
        playerdata.text = model.value
    }
    
}

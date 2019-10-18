//
//  HTTeamDataTableViewCell.swift
//  SportsLife
//
//  Created by seven on 2019/9/24.
//  Copyright © 2019 west. All rights reserved.
//

import UIKit

let playerCell = "playerCell"

class HTTeamDataTableViewCell: UITableViewCell {

    var headView = ChooseTypeHeaderView()
    var collectionView = UICollectionView.init(frame: CGRect(x: 0, y: 40.0, width: WIDTH, height: playerDataCellHeight), collectionViewLayout: UICollectionViewFlowLayout())
    
    var dataModel = recordTypeModel()
    
    typealias MoreDataBlock = (_ model:morelDataModel)->()
    var moreDataDetailBlock : MoreDataBlock?
    
    typealias PlayerDetailBlock = (_ model:playerDetailModel)->()
    var playerBlock : PlayerDetailBlock?
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.layout()
        self.configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func layout(){
     
        let layout = UICollectionViewFlowLayout.init()
        layout.minimumInteritemSpacing = 5 //行间距
        layout.minimumLineSpacing = 5  //列间距
        layout.itemSize = CGSize.init(width: playerDataCellWidth, height: playerDataCellHeight)
        layout.sectionInset = .init(top: 0, left: 5, bottom: 0, right: 5)
        layout.scrollDirection = .horizontal;
        self.collectionView.collectionViewLayout = layout;
        self.contentView.addSubview(collectionView)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
  
        
        
        
    }
    
    func configUI(){
        self.collectionView.backgroundColor = UIColor.white;
        self.collectionView.register(HTplayerInfoCollectionViewCell.self, forCellWithReuseIdentifier: playerCell)
        
    }

    func loadData(model:recordTypeModel){

        self.headView = ChooseTypeHeaderView.init(frame: CGRect(x: 0, y: 0, width: WIDTH, height: 40.0), leftBtnTitle: "", centerTitle: model.title != "" ? model.title : model.season , rightBtnTitle: model.show_more.title)
        self.contentView.addSubview(headView)

        headView.cancalClick = { str in
            print(str)
        }
        
        headView.confirmClick = {[weak self] str in
            print(str)
            if ((self?.moreDataDetailBlock) != nil) {
                self?.moreDataDetailBlock!(model.show_more)
            }
        }
        
        self.dataModel = model;
        self.collectionView.reloadData()
    }
}

extension HTTeamDataTableViewCell:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataModel.list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: playerCell, for: indexPath) as! HTplayerInfoCollectionViewCell
        let model = self.dataModel.list[indexPath.item]
        item.loadData(model: model)
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        https://data.zhibo8.cc/html/mobile/player.html?playerid=57&night=0
        let model = self.dataModel.list[indexPath.item]
        if self.playerBlock != nil {
            self.playerBlock!(model)
        }
    }
    
}

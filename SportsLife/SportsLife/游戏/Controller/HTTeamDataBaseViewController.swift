//
//  HTTeamDataBaseViewController.swift
//  SportsLife
//
//  Created by seven on 2019/9/23.
//  Copyright © 2019 west. All rights reserved.
//

import UIKit
import XLPagerTabStrip

@objcMembers
class HTTeamDataBaseViewController: ButtonBarPagerTabStripViewController {
    
    var headerView = UIImageView()
    
    var tabTitleArr = [teamTabDetail]()
    
    var teamId = ""
    var dataModel = HTTeamDataModel()

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil;
    }
    
    override func viewDidLoad() {
        self.loadData()
        self.setPageView()
        super.viewDidLoad()
        self.configUI()

    }
    
    func configUI(){
        self.view.backgroundColor = BGColor;
        self.headerView =  UIImageView.init(frame: CGRect(x: 0, y: 0, width: WIDTH, height: 100))
//        self.headerView.backgroundColor = UIColor.cyan;
        self.buttonBarView.frame = CGRect(x: 0, y: 100, width: WIDTH, height: 40);
        self.view.addSubview(headerView);
        
        let leftBtn = UIBarButtonItem.init(image: HTImage("Icon_Back").withRenderingMode(.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.popView))
        self.navigationItem.leftBarButtonItem = leftBtn;

    }
    
    func popView(){
        self.navigationController?.popViewController(animated: true)
    }

    
    func loadData(){
        HTTeamData().getTeamData(taemId: teamId, loadingView: self.view) {[weak self] (model, json) in
            self?.navigationItem.title = model.info.name_cn
            self?.dataModel = model;
            self?.tabTitleArr = self?.dataModel.tab.list ?? [teamTabDetail]()
            self?.headerView.kf.setImage(with:self?.dataModel.info.logo.stringToUrl())

            self?.reloadPagerTabStripView()
          
        }
        
    }

    func setPageView(){
        // change selected bar color
        settings.style.buttonBarBackgroundColor = UIColor.white
        settings.style.buttonBarItemBackgroundColor = UIColor.clear
        settings.style.selectedBarBackgroundColor = UIColor.orange//滑动线颜色
        settings.style.buttonBarItemFont = UIFont(name: "HelveticaNeue-Light", size:14) ?? UIFont.systemFont(ofSize: 14)
        //        settings.style.buttonBarItemFont = HTFont(14, "")
        settings.style.selectedBarHeight = 0
        settings.style.buttonBarMinimumLineSpacing = 5
        settings.style.buttonBarItemTitleColor = .red
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarHeight = naviHeight
        
        //        settings.style.buttonBarLeftContentInset = 15
        //        settings.style.buttonBarRightContentInset = 15
        changeCurrentIndexProgressive = {[weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = UIColor.black
            newCell?.label.textColor = .orange
            oldCell?.backgroundColor = UIColor.white
            
        }
        self.view.backgroundColor = UIColor.white
        
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        var arr = [HTTeamDataTableViewController]()
        for i in tabTitleArr {
            let vc = HTTeamDataTableViewController()
            vc.itemTitle.title = i.name
            if i.name == "资料" {
                vc.teamDataType = .info
            }else if i.name == "数据" {
                vc.teamDataType = .data

            }else if i.name == "阵容" {
                vc.teamDataType = .squad

            }else if i.name == "赛程" {
                vc.teamDataType = .schedule

            }else if i.name == "新闻"  || i.name == "资讯"{
                vc.teamDataType = .news

            }else if i.name == "视频" {
                vc.teamDataType = .video

            }else{
                
            }
            vc.api = i.api_url;
            arr.append(vc)
        }
        return arr.count > 0 ? arr : [HTTeamDataTableViewController()] ;
    }
}

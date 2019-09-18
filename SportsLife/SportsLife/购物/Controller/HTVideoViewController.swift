//
//  HTVideoViewController.swift
//  SportsLife
//
//  Created by seven on 2019/9/3.
//  Copyright © 2019 west. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import SwiftyJSON
import AVKit
import MJRefresh

class HTVideoViewController: HTBaseViewController ,UIWebViewDelegate,IndicatorInfoProvider,UITableViewDelegate,UITableViewDataSource{
    
    
    var tableView = UITableView();
    
    var dataArr = [HTVideoModel]();
    
    ///联赛
    var league = "中超"
    ///数据类型
    var tab    = "积分榜"//赛程
    ///年份
    var page:Int   = 0
    var isaddObserver:Bool = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
        self.loadData(page: page)
        self.refreshData()
        
    }
    //    MARK:# UI
    func configUI() {
        
        self.tableView.backgroundView?.backgroundColor = UIColor.gray
        self.tableView.backgroundColor = UIColor.gray
        self.tableView = UITableView.init(frame: CGRect(x: 0, y: 30, width: WIDTH, height: HEIGHT - naviHeight - 30 - bottomHeight - 49))
        self.tableView.register(HTVideoTableViewCell.self, forCellReuseIdentifier: "cell")

        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.view.addSubview(tableView)
//        self.setCellWeb()
        
    }
    
    func refreshData(){
        self.tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {[weak self] in
            self?.dataArr.removeAll();
            self?.loadData(page: 0)
        })
        
        self.tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: { [weak self] in
            self?.page += 1;
            self?.loadData(page: self?.page ?? 0)
        })
    }
    
    //    MARK:# 数据
    func loadData(page:Int) {
        
        HTVideoService().getVideoArr(league: league, page: "\(page)", loadingView: self.view) {[weak self] (arr, json) in
            self?.tableView.mj_header.endRefreshing()
            self?.tableView.mj_footer.endRefreshing()
            if arr.count > 0{
                self?.dataArr += arr
            }
            self?.tableView.reloadData()

        }
        
    }
    
    
    //    MARK:# 代理方法
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    //rowheaderheight
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.0001
        }
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:HTVideoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HTVideoTableViewCell
        cell.selectionStyle = .none
        let model = self.dataArr[indexPath.row]
        cell.setData(model: model)
        cell.btnClick = {[weak self] in
            print(model.url)
            self?.playVideo(url: model.url)
        }
        if indexPath.row == 0 {
            cell.selectionStyle = .none
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //    MARK:# 其他
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    var itemTitle:IndicatorInfo = "德甲"
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        
        return itemTitle
    }
    //ca-app-pub-9033627101784845/9430917797

    
    func playVideo(url:String){
        let vc = AVPlayerViewController.init()
        vc.player = AVPlayer(url: URL.init(string: url)!)
        self.present(vc, animated: true, completion: {
            vc.player?.play()
        })
    }
}

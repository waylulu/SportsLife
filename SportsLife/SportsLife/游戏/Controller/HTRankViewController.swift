//
//  HTRankViewController.swift
//  SportsLife
//
//  Created by seven on 2019/9/3.
//  Copyright © 2019 west. All rights reserved.
//

import UIKit
import SwiftyJSON
import Metal
import XLPagerTabStrip
import SDWebImage
import WebKit

class HTRankViewController:  HTBaseViewController ,IndicatorInfoProvider,UITableViewDelegate,UITableViewDataSource,YearDelegate,WKUIDelegate{
    
    
    var tableView = UITableView();
    
    var dataArr = [HTRankModel]();
    
    var cellWeb = WKWebView()
    ///联赛
    var league = "中超"
    ///数据类型
    var tab    = "积分榜"//赛程
    ///年份
    var year   = "2019"
    var isaddObserver:Bool = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
        self.loadData( year: year)
        
      
    }
    //    MARK:# UI
    func configUI() {
        
        self.tableView.backgroundView?.backgroundColor = UIColor.gray
        self.tableView.backgroundColor = UIColor.gray
        self.tableView = UITableView.init(frame: CGRect(x: 0, y: 30, width: WIDTH, height: HEIGHT - naviHeight - 30 - bottomHeight - 49))
        self.tableView.register(HTRankTableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.bounces = false
   
        //        frame.origin.y = naviHeight + 30
        //        self.tableView.frame = frame
        //        self.tableView.estimatedRowHeight = 0;
        //        self.tableView.estimatedSectionFooterHeight = 0;
        //        self.tableView.estimatedSectionHeaderHeight = 0;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.view.addSubview(tableView)
        self.setCellWeb()
        
        //
        //        var str = "121412132515125213123134125"
        //        let old = ["12","13"]
        //        let new = ["aa","bb"]
        //        str = HTrep(str, old, new)
        //        print(str)
        //        debugPrint(str)
        //        ChooseYearCallback = { str in
        //
        //        }
//        
//        let vc = HTRankBaseViewController()
//        vc.chooseYearDelagate = self
    }

    
    func chooseyear(_ yaer: String, _ league: String, _ tab: String) {
        self.year = yaer
        self.league = league
        self.tab = tab;
        self.loadData(year: yaer)
    }
    
    func setCellWeb(){
        
        cellWeb.uiDelegate = self
        cellWeb.load(URLRequest.init(url: URL.init(string: HTRuleWebUrl(league.chineseToPinYin()))!))
        
        self.tableView.tableFooterView = self.isRequest() ? cellWeb : nil
        
        
        if self.isRequest() {
            self.isaddObserver = true
            cellWeb.scrollView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        }
    }
    
    //    MARK:# 数据
    func loadData(year:String) {
        HTRankServices().getNewsArr(league: league, tab: tab, year: year, loadingView: self.view) {[weak self] (arr, json) in
            print(json)
            if arr.count > 0{
                self?.dataArr = arr;
            }else
            {
                let view = HTNODataView.init(frame: CGRect(x: 0, y: 30, width: WIDTH, height: HEIGHT - naviHeight - 30 - bottomHeight - 49), titleString: "noData")
                self?.tableView.tableFooterView = view
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
        return 30
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:HTRankTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HTRankTableViewCell
        let model = self.dataArr[indexPath.row];
        cell.setData(model: model, index: indexPath.row)
        if indexPath.row == 0 {
            cell.selectionStyle = .none
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let model = self.dataArr[indexPath.row]
        
        let vc = HTTeamDataBaseViewController()
        vc.teamId = model.teamId
        vc.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(vc, animated: true);
        
        
//        let vc = HTWebViewViewController();
//        vc.hidesBottomBarWhenPushed = true
////        vc.type = "zhibo8"//https://db.qiumibao.com/f/zuqiu/team/base?device=iPhone11%2C8&time_zone=Asia/Shanghai&id=138&appname=zhibo8&os=iOS&UDID=f9842ff0c21fc7e2e86133bd99bbddb21f463206&platform=ios&pk=com.zhibo8.tenyears&_platform=ios&version_code=4.8.4&os_version=12.4.1&usersports=1&blacks_status=enable&IDFA=2D6BD8E3-DA38-46B3-A4C4-749EF4F500F0
//        let url = "https://db.qiumibao.com/f/zuqiu/team/base?device=iPhone11%2C8&time_zone=Asia/Shanghai&id=\(model.teamId)&appname=zhibo8&os=iOS&UDID=f9842ff0c21fc7e2e86133bd99bbddb21f463206&platform=ios&pk=com.zhibo8.tenyears&_platform=ios&version_code=4.8.4&os_version=12.4.1&usersports=1&blacks_status=enable&IDFA=2D6BD8E3-DA38-46B3-A4C4-749EF4F500F0"//球队数据
////        self.navigationController?.pushViewController(vc, animated: true)
//        HTServices.htNet.getData(loadingView: self.view, urlString: url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!, method: .get, parameters: [:]) { json  -> (Void)  in
//            print(json)
//            AlertView.shard.alertDetail(controller: self, title: "点击了\(json)", bloack: {
//
//            })
//        }

    }
    
    
    //    MARK:# 其他
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //监听
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize"{
            print("forKeyPath");
            let s = object as! UIScrollView
            let h = s.contentSize.height
            
            let f = cellWeb.sizeThatFits(CGSize.zero)
            cellWeb.frame = CGRect.init(x: 0, y: 0, width: f.width, height: h)
            cellWeb.scrollView.frame =  CGRect.init(x: 0, y: 0, width: f.width, height:h)
            self.tableView.reloadData()
        }
        
    }
    
//    func webViewDidFinishLoad(_ webView: WKWebView) {
//
//
//        let height = (Double(self.cellWeb.stringByEvaluatingJavaScript(from: "document.body.offsetHeight")) ?? 0)
//        self.cellWeb.frame = CGRect(x: self.cellWeb.frame.origin.x, y: self.cellWeb.frame.origin.y, width: UIScreen.main.bounds.width, height: CGFloat(height))
//
//        self.tableView.reloadData()
//    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        var wh = 0.0
        print("didFinish");

        webView.evaluateJavaScript("document.body.offsetHeight") {[weak self] (val, err) in
            if (val != nil){
                let s = self?.cellWeb.sizeThatFits(CGSize.zero)
                if let h:Double = val as? Double {
                    wh = h
                }
                DispatchQueue.main.async { [unowned self] in
                    var tempFrame: CGRect = (self?.cellWeb.frame)!
                    tempFrame.size.height = CGFloat(wh)
                    self?.cellWeb.frame = tempFrame
//                    self.testScrollView.contentSize = CGSize(width: self.testScrollView.frame.size.width, height: self.changeWebView.frame.size.height + self.testLabel.frame.size.height)
                    self?.tableView.reloadData()

                }
            }
        }
        
           
    }
           
    
    deinit {
        if self.isaddObserver {
            self.cellWeb.scrollView.removeObserver(self, forKeyPath: "contentSize")
        }
    }
    
    
    var itemTitle:IndicatorInfo = "西甲"
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
  
        return itemTitle
    }
    
    
    func isRequest()->Bool{
        return  HelperClass.shared.requestUrl(urlString: HTRuleWebUrl(league.chineseToPinYin()))
    }

    
    func getData(){
        HTServices.htNet.getData(loadingView: self.view, urlString: yingChaoRickoUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!, method: .get, parameters: [:]) { json  -> (Void)  in
            
            AlertView.shard.alertDetail(controller: self, title: "点击了\(json)", bloack: {
                
            })
        }
        
    }

}





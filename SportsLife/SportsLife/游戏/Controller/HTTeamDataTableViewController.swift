//
//  HTTeamDataTableViewController.swift
//  SportsLife
//
//  Created by seven on 2019/9/19.
//  Copyright © 2019 west. All rights reserved.
////球队数据

import UIKit
import XLPagerTabStrip
import SwiftyJSON
import SwiftUI
import MJRefresh

enum TeamInfoType {
    case info,data,squad,schedule,news,video
}

let HTPlayerCell = "HTPlayerCell"
let defalutCell = "cell"
let squadCell = "squadCell"
let scheduleCell = "HTScheduleTableViewCell"
class HTTeamDataTableViewController: HTBaseViewController ,IndicatorInfoProvider,UITableViewDataSource,UITableViewDelegate{
    
    var scrollView = UIScrollView()
    var tableView = UITableView()
    var teamId = ""
    var dataModel = internalDataModel()
    var teamInfo = iteamInfoDataModel()
    var squadData = squad(json: JSON.null)
    var schedeleData = schedule(json: JSON.null)
    var headerView = ChooseTypeHeaderView()
    var newsDataArr = [newsDetailModel]()
    var tabTypeDataModel = ()
    var api = ""
    var time = TIME_MORE;
    var date = ""
    var teamDataType = TeamInfoType.info
    
    let s:(x:String,y:String) = ("","")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
        self.loadData(date: currentTime(TIME_MORE, "yyyy-MM-dd"))
//        let primes: Set = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37]
           ///     let x = 5
           ///     if primes.contains(x) {
           ///         print("\(x) is prime!")
           ///     } else {
           ///         print("\(x). Not prime.")
           ///     }
           ///     // Prints "5 is prime!"
           ///
        if self.teamDataType == .news {
            self.refreshData();
        }
       print(12000 - (3365/*房贷*/ + 800/*房租*/ + 2000/*吃*/ + 450/*约饭等*/ + 100/*电话费*/ + 200/*公交*/))
    }


    func configUI(){
        self.view.backgroundColor = UIColor.init(white: CGFloat(arc4random()), alpha: 1);
        self.tableView = UITableView.init(frame: CGRect(x: 0, y: 40 + 12, width: WIDTH, height: HEIGHT - 40 - 100), style: .plain);

        self.tableView.register(HTTeamDataTableViewCell.self, forCellReuseIdentifier: HTPlayerCell)
        self.tableView.register(HTSquadTableViewCell.self, forCellReuseIdentifier: squadCell)
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: defalutCell)
        self.tableView.register(HTScheduleTableViewCell.self, forCellReuseIdentifier: scheduleCell)
        
        tableView.register(HTHotNewsTableViewCell.self, forCellReuseIdentifier: hCellId)

        self.view.addSubview(self.tableView)
        self.tableView.dataSource = self;
        self.tableView.delegate  = self
//       api =    "https://api.qiumibao.com/application/app/?_url=/news/list&date=2019-09-30&label=皇家马德里&word=皇家马德里&_section=news&team_id=165&category=football"   //2019-09-30
        

     }
    
    
    func loadData(date:String){
        
        switch self.teamDataType {
        case .info:
            
            HTTeamData().getTeamInfoData(dataApi: api, loadingView: self.view) {[weak self] (model, json)  in
                print(json);
                self?.teamInfo = model;
                self?.tableView.reloadData()

            }
        case .data:
            HTTeamData().getInternalTeamData( dataApi: api, loadingView: self.view) {[weak self] (model, json) in
               print(json)
               self?.dataModel = model;
               self?.tableView.reloadData()

            }
            
        case .squad:
            HTTeamData().getSquadData(dataApi: api, loadingView: self.view) {[weak self] (model, json) in
                print(json)
                self?.squadData = model
                self?.tableView.reloadData()
                
            }
            
        case .schedule:
            HTTeamData().getScheduleData(dataApi: api, loadingView: self.view) {[weak self] (model, json) in
                print(json)
                self?.schedeleData = model
                self?.tableView.reloadData()

                for i in 0..<self!.schedeleData.data.count{
                    if self?.schedeleData.data[i].title == currentTime(TIME_MORE,"yyyy-MM") {
                        self?.tableView.scrollToRow(at: IndexPath.init(row: 0, section: i), at: .top, animated: false)
                    }
                }

            }
        case .news :
            HTTeamData().getNewsData(dataApi: (api + "&date=\(date)"), loadingView: self.view) {[weak self] (model, json) in
                print(((self?.api ?? "") + "&date=\(date)"));
                if model.list.count > 0{
                    self?.tableView.mj_footer.endRefreshing();
                    self?.tableView.mj_header.endRefreshing();
                    self?.newsDataArr += model.list
                     if self?.newsDataArr.count ?? 0 < 10{
                        let s = self?.newsDataArr.last?.createtime.suffix(10)
                        self?.date = (s?.base)!;
                        self?.loadData(date: self?.date ?? "2019-10-14");
                                    
                     };
                                    

                }else{
                    TIME_MORE -= (24 * 60 * 60)
                    self?.loadData(date: currentTime(TIME_MORE, "yyyy-MM-dd"));
//                    let view = HTNODataView.init(frame: CGRect.init(x: 0, y: 70, width: WIDTH, height: HEIGHT - 70), titleString: "暂无数据")
//                    self?.tableView.tableFooterView = view;
                }
             self?.tableView.reloadData();

            }
        default:
                break;
        }
      
        

    }
    
    
    func refreshData(){
        self.tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {[weak self] in
            TIME_MORE = (-8 * 60 * 60) ;
            self?.newsDataArr.removeAll();
            self?.loadData(date: (String(describing: currentTime(TIME_MORE, "yyyy-MM-dd"))))
        })
        
        self.tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: { [weak self] in
//            self?.time -= (24 * 60 * 60) ;
            self?.loadData(date: self?.date ?? "2019-10-14")
        })
    }
    
    
  
    var itemTitle:IndicatorInfo = ""
}

extension HTTeamDataTableViewController{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        
        
        return itemTitle;
    }
    
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.teamDataType == .info {
            return 2
        }else if self.teamDataType == .squad{
           return 1 + self.squadData.squad.count
        }else if self.teamDataType == .schedule{
            return self.schedeleData.data.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if self.teamDataType == .info {
            if section == 0 {
                return self.teamInfo.info.count
            }
            else{
                return 1
            }
        }else if self.teamDataType == .squad{
            if section == 0 {
                return self.squadData.coaching_staff.list.count
            }
            return self.squadData.squad[section - 1].list.count
        }else if self.teamDataType == .schedule{
            
            return self.schedeleData.data[section].list.count
            
        }else if self.teamDataType == .news {
            return self.newsDataArr.count
        }
        return self.dataModel.record.list.count
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if self.teamDataType == .squad  || self.teamDataType == .schedule{
            return 30
        }
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if  self.teamDataType == .squad {
            headerView = ChooseTypeHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: WIDTH, height: 30), leftBtnTitle: "", centerTitle: section == 0 ? self.squadData.coaching_staff.title : self.squadData.squad[section - 1].title, rightBtnTitle: section == 0 ? self.squadData.coaching_staff.show_more.title : "")

            headerView.confirmClick = {[weak self] title in
                self?.pushMoreTeamData(url: (self?.squadData.coaching_staff.show_more.url)!)
            }
            return headerView
        }else if self.teamDataType == .schedule {
        
            headerView = ChooseTypeHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: WIDTH, height: 30), leftBtnTitle: self.schedeleData.data[section].title, centerTitle:"", rightBtnTitle:"")
     
//                headerView.cancalClick = {[weak self] title in
//                    self?.pushMoreTeamData(url: (self?.squadData.coaching_staff.show_more.url)!)
//                }
            return headerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.teamDataType == .info {
            if indexPath.section == 1 {
                let text = self.teamInfo.intro.data;
                let rect = text.heightWithFont(font: HTdefalutFont, maxSize: CGSize.init(width: WIDTH, height: HEIGHT))
                return rect.height + 60;
            }
            return 40;
        } else if self.teamDataType == .squad || self.teamDataType == .schedule{
            return  self.teamDataType == .schedule ? 50 : 70;
        }else if self.teamDataType == .news {
            return hotCellHeight;
        }
        return playerDataCellHeight + 40 + 10 ;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if self.teamDataType == .info {
            if indexPath.section == 0 {
                let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: defalutCell)

                cell.textLabel?.text = self.teamInfo.info[indexPath.row].key
                cell.detailTextLabel?.text = self.teamInfo.info[indexPath.row].value
                cell.detailTextLabel?.textColor =  indexPath.row == 3 ? UIColor.blue : UIColor.black
                cell.textLabel?.font = HTdefalutFont;
                cell.detailTextLabel?.font = HTdefalutFont;
                cell.selectionStyle = .none;
                return cell

            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: defalutCell, for: indexPath)
                cell.textLabel?.font = HTdefalutFont;
                cell.detailTextLabel?.font = HTdefalutFont;
                if indexPath.section == 1
                {
                    cell.selectionStyle = .none
                    cell.textLabel?.text = self.teamInfo.intro.data
                    cell.textLabel?.numberOfLines = 0;
                }
                return cell

            }
        
        }else if self.teamDataType == .squad{
            let cell = tableView.dequeueReusableCell(withIdentifier: squadCell, for: indexPath) as! HTSquadTableViewCell
            if indexPath.section == 0 {
                
                cell.setCoachData(model: self.squadData.coaching_staff.list[indexPath.section])
            }else {
                cell.setPlayerData(model: self.squadData.squad[indexPath.section - 1].list[indexPath.row])
            }
            return cell
        }else if self.teamDataType == .schedule {
            let cell = tableView.dequeueReusableCell(withIdentifier: scheduleCell, for: indexPath) as! HTScheduleTableViewCell
            print( self.schedeleData.data[indexPath.section].list[indexPath.row])
            cell.setData(model: self.schedeleData.data[indexPath.section].list[indexPath.row])
            return cell
            
        }else if self.teamDataType == .news {
        let cell:HTHotNewsTableViewCell = tableView.dequeueReusableCell(withIdentifier: hCellId, for: indexPath) as! HTHotNewsTableViewCell
            cell.setNewsData(model: self.newsDataArr[indexPath.row]);
            return cell;
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier:HTPlayerCell , for: indexPath) as! HTTeamDataTableViewCell
                 let model = self.dataModel.record.list[indexPath.row]
                 cell.selectionStyle = .none;
                 cell.loadData(model: model)
                 
                 cell.moreDataDetailBlock = {[weak self] moreModel in
                     self?.pushMoreTeamData(url: moreModel.url)
                 }
                 cell.playerBlock = {[weak self] playerModel in//        https://data.zhibo8.cc/html/mobile/player.html?playerid=57&night=0
                     let url = "https://data.zhibo8.cc/html/mobile/player.html?playerid=\(playerModel.player_id)&night=0";
                     self?.pushMoreTeamData(url: url)
                 }
                 
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if self.teamDataType == .info {
            if indexPath.section == 0 && indexPath.row == 3{
                self.pushMoreTeamData(url: self.teamInfo.info[indexPath.row].value)
            }
        }else if  self.teamDataType == .squad {
            if indexPath.section == 0 {
                           
                let model =  self.squadData.coaching_staff.list[indexPath.section]
                self.pushMoreTeamData(url: model.redirect.url)
            }else {
                let model =  self.squadData.squad[indexPath.section - 1].list[indexPath.row]
                let url = "https://data.zhibo8.cc/html/mobile/player.html?playerid=\(model.id)&night=0";
                self.pushMoreTeamData(url: url)
            }
        }else if self.teamDataType == .schedule{
            let model = self.schedeleData.data[indexPath.section].list[indexPath.row]
//            https://m.zhibo8.cc/zhibo/zuqiu/2019/0108165736.htm
            self.pushMoreTeamData(url: "https://m.zhibo8.cc/" + model.detailUrl)

        }
            
    }
    
    
    func pushMoreTeamData(url:String){
        let vc = HTWebViewViewController();
        vc.hidesBottomBarWhenPushed = true
        vc.type = "zhibo8"
        vc.url =  HTurlString(url)
        vc.isNews = self.teamDataType == .news ? true : false;
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}




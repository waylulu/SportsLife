//
//  MineTableViewController.swift
//  SportsLife
//
//  Created by WTW on 2018/6/20.
//  Copyright © 2018年 west. All rights reserved.
//

import UIKit

class MineTableViewController: HTBaseTableViewController {

    var defaultPayData:(payType:String,model:CardsModel)?
    var defaultData:(payType:String,model:CardsModel)?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
        self.loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //    MARK:# UI
    func configUI() {
        self.navigationItem.title = "个人中心"
        self.tabBarItem.title = "个人中心"
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//       let s =  1500 - 10.92 = 1489.08
        
    }
    //    MARK:# 数据
    func loadData() {
        
    }
    //    MARK:# 代理方法
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    //rowheaderheight
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.0001
        }
        return 10
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "cell")
        cell.textLabel?.text = "\(indexPath.row)";
        cell.detailTextLabel?.text = "\(indexPath.row)";
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);//设置后取消点击后的灰色
//        self.MBProgressHUDWithMessage(message: "点击了\(indexPath.row)");
        let cell = tableView.cellForRow(at: indexPath);
        
        if indexPath.row == 0 {
            let vc = OCViewController()
            vc.hidesBottomBarWhenPushed = true;
            self.navigationController?.pushViewController(vc, animated: true)
            return;
            
        }else if indexPath.row == 1{
            
            let actvc = UIActivityViewController.init(activityItems: ["test",HTImage("a"),URL.init(string: "www.baidu.com")!], applicationActivities: nil)
            actvc.view.backgroundColor = UIColor.white
            self.navigationController?.present(actvc, animated: true, completion: nil)
            return;
        }else if indexPath.row == 2{
            AlertView.shard.alertDetail(controller: self, title:"test", bloack: {
                              
                self.view.addSubview(SwiftUIView_Previews.previews as! UIView);
            })
            
            
            return;
        }
        let vc = PresentChooseViewController()
        vc.modalPresentationStyle = .custom//蒙版风格overCurrentContext:tabbar跳转,custom
        vc.modalTransitionStyle = .crossDissolve;//跳转的风格
        self.presentingViewController?.definesPresentationContext = true;
        //        self.tabBarController?.tabBar.isHidden = true;

        vc.centerTitle = "选择展示的内容"
        
        if (self.defaultPayData != nil) && cell?.detailTextLabel?.text == self.defaultPayData?.payType{
            vc.choosePayData =  self.defaultPayData
            vc.cardType = .more
        }else if defaultData != nil && cell?.detailTextLabel?.text == self.defaultData?.model.title{
            vc.choosePayData =  self.defaultData
            vc.cardType = .one
        }
        
        self.present(vc, animated: true) {
        }
        
        //type = ""时是其他选择.不等于""是选择了支付方式
        vc.choosePayTypeBlock = {[weak self] type ,model in
            cell?.detailTextLabel?.text = type == "" ? model.title : type
            if type == "" {
                self?.defaultData = (type,model)
            }else{
                self?.defaultPayData = (type,model)
            }
        }
    }
 
    
    
    @available(iOS 11.0, *)
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let d = UIContextualAction.init()
        d.image = HTImage("a")
        
        return UISwipeActionsConfiguration.init(actions: [d]);
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
}


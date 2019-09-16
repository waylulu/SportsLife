//
//  SportsTableViewController.swift
//  SportsLife
//
//  Created by WTW on 2018/6/20.
//  Copyright © 2018年 west. All rights reserved.
//

import UIKit
import Alamofire



@objcMembers
class SportsTableViewController: HTBaseViewController,UITableViewDelegate,UITableViewDataSource {
    var scrollView = UIScrollView()
    var seg = UISegmentedControl()
    var tableViewArr = [UITableView]()
    var segmentTitles = ["热文","比分"]
    var model = HTNewsDataViewModel()
    var newsArr = [HTNewsModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
        self.loadData()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.seg.isHidden = false;
    }
    //    MARK:# UI
    func configUI() {
        
        let rightItem = UIBarButtonItem.init(title: "扫描", style: UIBarButtonItem.Style.plain, target: self, action: #selector(rightClick))
        self.navigationItem.rightBarButtonItem = rightItem;
        self.automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = UIColor.white;
        self.setSegmentUI()
        self.setScrollviewUI()
        self.setTableViewUI();

    }

    func rightClick(){
        let vc = HTQRCodeViewController()
        vc.hidesBottomBarWhenPushed = true;
        self.seg.isHidden = true;
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setSegmentUI(){
        seg = UISegmentedControl.init(items: segmentTitles);
        seg.frame = CGRect(x: (WIDTH -  SegWidth * CGFloat(segmentTitles.count)) / 2, y: 0, width: SegWidth * CGFloat(segmentTitles.count), height: 35)
        self.navigationController?.navigationBar.addSubview(seg);
        seg.backgroundColor = UIColor.white;
        seg.tintColor = UIColor.orange;
        seg.selectedSegmentIndex = 0;
        seg.addTarget(self, action: #selector(self.segmentClick(segment:)), for: UIControl.Event.valueChanged);
    
    }
    
    func setScrollviewUI(){
        
        scrollView = UIScrollView.init(frame: CGRect(x: 0, y: 0, width: WIDTH, height: HEIGHT))
        scrollView.contentSize = CGSize.init(width: WIDTH * CGFloat(segmentTitles.count), height: HEIGHT)
        scrollView.alwaysBounceHorizontal = true;
        scrollView.isPagingEnabled = true;
        scrollView.delegate = self;
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)
        
  
    }
    
    
    func setTableViewUI(){
        for i in 0..<segmentTitles.count {
            let tableView = UITableView.init(frame: CGRect(x: WIDTH * CGFloat(i), y: naviHeight, width: WIDTH, height: HEIGHT - naviHeight)) 
            
            tableView.tag = i;
            tableView.register(UINib.init(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
            if i == 0 {
                tableView.register(HTHotNewsTableViewCell.self, forCellReuseIdentifier: hCellId)
            }
            tableView.dataSource = self;
            tableView.delegate = self
            self.tableViewArr.append(tableView)
//            view.backgroundColor = i == 1 ? UIColor.cyan : UIColor.green
            scrollView.addSubview(tableView)
        }
    }
    //    MARK:# 数据
    func loadData() {

//        HTServices.htNet.getData(urlString: newsUrl, method: .get, parameters: [:]) { (json) -> (Void) in
//            DispatchQueue.main.async {
//                if json["toplist"].arrayValue.count > 0{
//                    for js in json["toplist"].arrayValue {
//                        self.newsArr.append(HTNewsModel.init(json: js))
//                    }
//                }
//                for tab in self.tableViewArr {
//                    tab.reloadData()
//                }
//            }
//
//        }
        HTNewsDataViewModel().getNewsArr(loadingView: self.view) {[weak self] arr,json  in
//            DispatchQueue.main.async {
    
                if arr.count > 0{
                    self?.newsArr = arr;
                    for tab in self?.tableViewArr ?? [] {
                        tab.reloadData()
                    }
                }else{
                    AlertView.shard.alertDetail(controller: self!, title: json.stringValue, bloack: {
                        
                    })
                }
             
//            }
           
        }

        
//       self.newsArr = self.model.getNewsArr()
//        self.newsArr = self.model.newsModels
        
     
        
    }
    //    MARK:# 代理方法
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 0 {
            return newsArr.count
        }
        return 10
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
        let view = UIView.init()
        return view
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init()
        return view
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.tag == 0 {
            return hotCellHeight
        }
        return 40
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView.tag == 0 {
            let cell:HTHotNewsTableViewCell = tableView.dequeueReusableCell(withIdentifier: hCellId, for: indexPath) as! HTHotNewsTableViewCell
            cell.setData(model: self.newsArr[indexPath.row])
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = "\(arc4random())";
            return cell
        }
      
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        let url = URL(string: "https://itunes.apple.com/us/app/%E7%83%AD%E5%8A%9B%E8%B6%B3%E7%90%83/id1224540082?l=zh&ls=1&mt=8")!
//        UIApplication.shared.openURL(url)
        let model = self.newsArr[indexPath.row]
        let vc = HTWebViewViewController();
        vc.hidesBottomBarWhenPushed = true
        vc.type = "zhibo8"
        vc.url = "https://m.zhibo8.cc/news/web" + model.url
        self.navigationController?.pushViewController(vc, animated: true)
//        https://m.zhibo8.cc/news/web/zuqiu/2019-09-03/5d6e7562d45b4.htm?key=20190904095944
//        self.getData()
//        self.login();
//        AlertView.shard.MBProgressHUDWithMessage(view: self.view, message: "点击了第\(tableView.tag)tableView的\(indexPath.row)")
    }
    //    MARK:# 其他
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        seg.isHidden = true

    }
    /**
     vcode    8274
     ip    192.168.1.68
     version_code    4.8.3
     time    1567649205
     usersports    1
     operator    46001
     ts    1567649206
     opentype    phone
     IDFA    00000000-0000-0000-0000-000000000000
     vendor    Apple
     udid    f9842ff0c21fc7e2e86133bd99bbddb21f463206
     lan    zh-Hans-CN
     os    iOS
     geo    113.947532,22.540005
     net    2
     appname    zhibo8
     openudid    f9842ff0c21fc7e2e86133bd99bbddb21f463206
     orientation    0
     phone_no    13296697969
     UDID    f9842ff0c21fc7e2e86133bd99bbddb21f463206
     _platform    ios
     time_zone    Asia/Shanghai
     os_version    12.4
     chk    1c71d3faa5da2972b0e4be7fefa047c9
     pk    com.zhibo8.tenyears
     density    359
     model    iPhone11,8
     zone_code    +86
     device    iPhone11,8
     blacks_status    disable
     */

    
    /**
     device    iPhone11,8
     time_zone    Asia/Shanghai
     gateway_sdk_version    2.2
     verify_id    1935715
     appname    zhibo8
     time    1567649206
     os    iOS
     UDID    f9842ff0c21fc7e2e86133bd99bbddb21f463206
     pk    com.zhibo8.tenyears
     chk    3d7ed38189a41b477ed949a0b1f87f89
     _platform    ios
     version_code    4.8.3
     os_version    12.4
     usersports    1
     blacks_status    disable
     IDFA    00000000-0000-0000-0000-000000000000
     */
    
}
extension SportsTableViewController{
    func segmentClick(segment :UISegmentedControl){
        let index = segment.selectedSegmentIndex;
        //改变当前的显示范围
        scrollView.setContentOffset(CGPoint(x: WIDTH * CGFloat(index), y: 0), animated: true);
 
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(scrollView.contentOffset.x)
//        if scrollView == self.scrollView {
//            self.seg.selectedSegmentIndex = Int(scrollView.contentOffset.x / WIDTH)
//        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            self.seg.selectedSegmentIndex = Int(scrollView.contentOffset.x / WIDTH)
        }
    }
    
    
    
    func getData(){
        HTServices.htNet.getData(loadingView: self.view, urlString: yingChaoRickoUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!, method: .get, parameters: [:]) { json  -> (Void)  in

            AlertView.shard.alertDetail(controller: self, title: "点击了\(json)", bloack: {
                
            })
        }

    }
    
    func login(){
        let dic = ["user_auth":"bf5Pqu7yrG3110vAulsqk6x807%2Bqp8XlApTwqy1etrkBfrR%2BhGR8IGBAcWNjA%2FeT0jizECpj%2Bggaw7YDeLnlu%2Fpz8F2rk1mrNVFrWLS0QXuSL8wfmYYz6YvRXzTrJEcGl%2691bcg3Zb5p6eK3Jkp4cIyiui%2BPVWz5rf15f3yDNri4jizhgi1kg%60pHiFZeiBMvdTGGuRv5GXg9sYxv","is_rookie":"0"]
        HTServices.htNet.getData(loadingView: self.view, urlString: "https://pl.zhibo8.cc/mobile/sms_login_and_check.php", method: .post, parameters: dic) { (json) -> (Void) in
            print(json)
        }
    }
  
}

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

        self.getData()

//        AlertView.shard.MBProgressHUDWithMessage(view: self.view, message: "点击了第\(tableView.tag)tableView的\(indexPath.row)")
    }
    //    MARK:# 其他
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
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
//        HTServices.htNet.getAFNData(urlString:  yingChaoRickoUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!, method: .get, parameters: [:]) { (json, err) -> (Void) in
//            AlertView.shard.alertWithTitle(controller: self, title: "点击了\(json)", bloack: {
//
//            })
//        }
    }
    
}

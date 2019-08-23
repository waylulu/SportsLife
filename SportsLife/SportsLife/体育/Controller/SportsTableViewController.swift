//
//  SportsTableViewController.swift
//  SportsLife
//
//  Created by WTW on 2018/6/20.
//  Copyright © 2018年 west. All rights reserved.
//

import UIKit

@objcMembers
class SportsTableViewController: HTBaseViewController,UITableViewDelegate,UITableViewDataSource {
    var scrollView = UIScrollView()
    var seg = UISegmentedControl()
    var tableViewArr = NSMutableArray()
    var segmentTitles = ["第一","第二"]
    
    
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
//        self.navigationItem.title = "体育"
//        self.tabBarItem.title = "体育"
        
        let rightItem = UIBarButtonItem.init(title: "扫描", style: UIBarButtonItem.Style.plain, target: self, action: #selector(rightClick))
        self.navigationItem.rightBarButtonItem = rightItem;
        self.automaticallyAdjustsScrollViewInsets = false
     
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
//        segmentTitles = ["1","2","3","4"]
        seg = UISegmentedControl.init(items: segmentTitles);
        seg.frame = CGRect(x: (WIDTH - SegWidth) / 2, y: 0, width: SegWidth, height: 35)
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
            let tableView = UITableView.init(frame: CGRect(x: WIDTH * CGFloat(i), y: naviHeight, width: WIDTH, height: HEIGHT))
            
            tableView.tag = i;
            tableView.register(UINib.init(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
            tableView.dataSource = self;
            tableView.delegate = self
            view.backgroundColor = i == 1 ? UIColor.cyan : UIColor.green
            scrollView.addSubview(tableView)
        }
    }
    //    MARK:# 数据
    func loadData() {
        
    }
    //    MARK:# 代理方法
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
        return 40
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print(tableView.tag);
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)";
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        AlertView.shard.MBProgressHUDWithMessage(view: self.view, message: "点击了第\(tableView.tag)tableView的\(indexPath.row)")
    }
    //    MARK:# 其他
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension SportsTableViewController{
    func segmentClick(segment :UISegmentedControl){
        print("segmentClick");
        let index = segment.selectedSegmentIndex;
        //改变当前的显示范围
        scrollView.setContentOffset(CGPoint(x: WIDTH * CGFloat(index), y: 0), animated: true);
 
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        self.seg.selectedSegmentIndex = Int(scrollView.contentOffset.x / WIDTH)
    }
    
}

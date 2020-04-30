//
//  SportsTableViewController.swift
//  SportsLife
//
//  Created by WTW on 2018/6/20.
//  Copyright © 2018年 west. All rights reserved.
//

import UIKit
import Alamofire
import MJRefresh
import Photos
import AssetsLibrary


@objcMembers
class SportsTableViewController: HTBaseViewController,UITableViewDelegate,UITableViewDataSource {
    var scrollView = UIScrollView()
    var seg = UISegmentedControl()
    var tableViewArr = [UITableView]()
    var segmentTitles = ["热文","比分"]
    var model = HTNewsDataViewModel()
    var newsArr = [newsDetailModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
        self.loadData(time: TIME_MORE)
        self.refreshData()
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
        self.testClassAndStruct()

    }
    
    
    func testClassAndStruct(){
        /**
         引用类型：将一个对象赋值给另一个对象时，系统不会对此对象进行拷贝，而会将指向这个对象的指针赋值给另一个对象，当修改其中一个对象的值时，另一个对象的值会随之改变。

         值类型：将一个对象赋值给另一个对象时，会对此对象进行拷贝，复制出一份副本给另一个对象，在修改其中一个对象的值时，不影响另外一个对象。

         在swift中，类属于引用类型，结构体属于值类型，相对于其他语言来说，swift的结构体功能更加强大，它除了支持在结构体声明中基础变量之外，它还支持在结构体中声明方法，这相对于其他语言来说，是swift的一个特性之一。此外，除了引用类型和值类型的区别之外，他们还有其他的不同点，下面总结一下在swift中类和结构体的不同点：

         不同点：1.类属于引用类型，结构体属于值类型

         2.类允许被继承，结构体不允许被继承

         3.类中的每一个成员变量都必须被初始化，否则编译器会报错，而结构体不需要，编译器会自动帮我们生成init函数，给变量赋一个默认值
         
         */
        ///1.类属于引用类型,
        let testClassA = TestClass()
        
        print(testClassA.a)//1
        print(testClassA.b)//testClassA
        
        testClassA.a = 2;
        testClassA.b = "test";
        print(testClassA.a)//2
        print(testClassA.b)//test
        
        let testCalssB = testClassA;//使用testClassAtest新建一个
        
        testCalssB.a = 3
        testCalssB.b = "testClassB"
        
        print(testClassA.a)//3
        print(testClassA.b)//testClassB
        
        
        
        
        ///值类型
        var testStructA = TestStruct()
        
        print(testStructA.a)
        print(testStructA.b)
        
        
        testStructA.a = 5;
        testStructA.b = "testStructA"
        
        print(testStructA.a)
        print(testStructA.b)
        
        
        var testStructB = testStructA
        
        testStructB.a = 6
        
        testStructB.b = "testStructB"
        
        print(testStructA.a)
        print(testStructA.b)
        
        print([5,6,2,6,7,23,7,2,347,45,4363,2,346,3].sorted())
        print([5,6,2,6,7,23,7,2,347,45,4363,2,346,3].sorted(by: {$0>$1}))
    }

    func rightClick(){
        
        var i:Int = 0;
        
        for j in 0...10 {
            i += j;
        }
        print(i)

        
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
        if #available(iOS 13.0, *) {
            seg.selectedSegmentTintColor = UIColor.orange
        } else {
            seg.tintColor = UIColor.orange
        };
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
            }else{
                
                tableView.register(HTScoreTableViewCell.self, forCellReuseIdentifier: sCell)

            }
            tableView.dataSource = self;
            tableView.delegate = self
            self.tableViewArr.append(tableView)
//            view.backgroundColor = i == 1 ? UIColor.cyan : UIColor.green
            scrollView.addSubview(tableView)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
        }
        
    }
    
    
    func refreshData(){
        self.tableViewArr[self.seg.selectedSegmentIndex].mj_header = MJRefreshNormalHeader.init(refreshingBlock: {[weak self] in
            TIME_MORE = (-8 * 60 * 60) ;
            self?.newsArr.removeAll();
            self?.loadData(time: TIME_MORE)
        })
        
        self.tableViewArr[self.seg.selectedSegmentIndex].mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: { [weak self] in
            TIME_MORE -= (24 * 60 * 60) ;
            self?.loadData(time: TIME_MORE)
        })
    }
    
    //    MARK:# 数据
    func loadData(time:Double) {

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
        HTNewsDataViewModel().getNewsArr(url: newsUrl(time), loadingView: self.view) {[weak self] arr,json  in
    
            self?.tableViewArr[0].mj_footer.endRefreshing()
            self?.tableViewArr[0].mj_header.endRefreshing()
            if arr.count > 0{
                self?.newsArr += arr;
                if arr.count < 10{
                    TIME_MORE -= (24 * 60 * 60) ;
                    self?.loadData(time: TIME_MORE)
                    
                }
                for tab in self?.tableViewArr ?? [] {
                    tab.reloadData()
                }
            }else{
                AlertView.shard.alertDetail(controller: self!, title: json.stringValue, bloack: {
                    
                })
                
            }
             
           
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
        return 20
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
        return scoreHeight
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView.tag == 0 {
            let cell:HTHotNewsTableViewCell = tableView.dequeueReusableCell(withIdentifier: hCellId, for: indexPath) as! HTHotNewsTableViewCell
            cell.setNewsData(model: self.newsArr[indexPath.row])
            return cell
        }else{
            
            let cell:HTScoreTableViewCell = tableView.dequeueReusableCell(withIdentifier: sCell, for: indexPath) as! HTScoreTableViewCell

//            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//            cell.textLabel?.text = "\(arc4random())";
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
//        AlertView.shard.MBProgressHUDWithMessage(view: self.view, message: "点击了第\(tableView.tag)tableView的\(indexPath.row)")
        if indexPath.section == 0 && indexPath.row == 0 {
//            self.login();
            let t:Any = a(arg: 1, a: 1)
            print(t)
        }
    }
    

    func a<T>(arg:T,a:T){
        print(arg);
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
        HTServices.htNet.getData(loadingView: self.view, urlString: yingChaoRickoUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!, method: .get, parameters: [:]) {[weak self] json  -> (Void)  in

            AlertView.shard.alertDetail(controller: self!, title: "点击了\(json)", bloack: {
                
            })
        }

    }
    
    func login(){
        let dic = ["user_auth":"bf5Pqu7yrG3110vAulsqk6x807%2Bqp8XlApTwqy1etrkBfrR%2BhGR8IGBAcWNjA%2FeT0jizECpj%2Bggaw7YDeLnlu%2Fpz8F2rk1mrNVFrWLS0QXuSL8wfmYYz6YvRXzTrJEcGl%2691bcg3Zb5p6eK3Jkp4cIyiui%2BPVWz5rf15f3yDNri4jizhgi1kg%60pHiFZeiBMvdTGGuRv5GXg9sYxv","is_rookie":"0"]
        HTServices.htNet.getData(loadingView: self.view, urlString: "https://pl.zhibo8.cc/mobile/sms_login_and_check.php", method: .post, parameters: dic) {[weak self] (json) -> (Void) in
            print(json)
        }
    }
  
}

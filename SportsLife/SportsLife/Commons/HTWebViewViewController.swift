//
//  HTWebViewViewController.swift
//  SportsLife
//
//  Created by seven on 2019/8/21.
//  Copyright © 2019 west. All rights reserved.
//

import UIKit
import WebKit
import GoogleMobileAds

@objcMembers
class HTWebViewViewController: HTBaseViewController ,WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler,GADAdSizeDelegate{


    var webView = WKWebView()
    var userContent = WKUserContentController()
    var config = WKWebViewConfiguration.init()
    var progressView = UIProgressView()
    var progress = CGFloat()
    var url = String()
    var closeBtn = UIButton()
    var type = ""
    var bannerView: GADBannerView!
    var isNews :Bool = true;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
        self.setWebUI()
        self.setProgressView()
        self.loadData()
        self.ads()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.webView.addObserver(self, forKeyPath: "title", options: .new, context: nil);
        self.webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil);

    }

    func configUI(){
        self.view.backgroundColor = UIColor.white;
        self.setBarItem()
    }
    
    func setBarItem(){
        let leftItem1 = UIBarButtonItem.init(title: "返回", style: UIBarButtonItem.Style.plain, target: self, action: #selector(goBackWeb))
//        closeBtn = UIButton.init(title: "关闭", style: UIBarButtonItem.Style.plain, target: self, action: #selector(closeWeb))
        
        closeBtn = UIButton.init(frame: CGRect(x: 0, y: 0, width: 40, height: 60));
        closeBtn.setTitle("关闭", for: .normal)
        closeBtn.setTitleColor(UIColor.red, for: UIControl.State.normal);
        closeBtn.isHidden = true;
        closeBtn.addTarget(self, action: #selector(closeWeb), for: UIControl.Event.touchUpInside);
        
        self.navigationItem.leftBarButtonItems = [leftItem1,UIBarButtonItem.init(customView: closeBtn)];
        
        let rightItem = UIBarButtonItem.init(title: "refresh", style: UIBarButtonItem.Style.plain, target: self, action: #selector(refreshWeb))
        self.navigationItem.rightBarButtonItem = rightItem;
    }
    
    func setProgressView(){
        progressView = UIProgressView.init(frame: CGRect(x: 0, y: naviHeight, width: WIDTH, height: 1));
        self.view.addSubview(progressView);
        progressView.trackTintColor = UIColor.clear;//默认背景色
        progressView.progressTintColor = UIColor.purple
        progressView.transform = CGAffineTransform(scaleX: 1.0, y: 2.0)//x长度 y宽度的缩放
    }

    func setWebUI(){
        userContent = WKUserContentController.init()
        config = WKWebViewConfiguration.init()
        config.userContentController = userContent
        
        if #available(iOS 10.0, *) {
            config.mediaTypesRequiringUserActionForPlayback = .all
        } else {
            self.config.allowsInlineMediaPlayback = false;
        }
        config.allowsInlineMediaPlayback = true;
        config.allowsAirPlayForMediaPlayback = true;
        
        webView = WKWebView.init(frame:CGRect.init(x: 0, y: 60, width: WIDTH, height: HEIGHT - 60), configuration: config);
        if isNews == false {
            var rect = webView.frame;
            rect.origin.y += 50
            webView.frame = rect;
        }
        self.view.addSubview(webView);
        self.webView.scrollView.bounces = false;//回弹效果
        self.webView.scrollView.showsVerticalScrollIndicator = false;
    }

    func loadData(){
        if url.contains("http://") || url.contains("https://"){
//            if type == "zhibo8"{
//                self.editWebData()
//            }else{
                self.webView.navigationDelegate = self;
                self.webView.uiDelegate = self;
            webView.load(URLRequest.init(url: URL.init(string: url) ?? URL.init(string: "https://baidu.com")!))
//            }

        }else{
//            let errorString = try! String.init(contentsOfFile: Bundle.main.path(forResource: url, ofType: "html")!)
//
//            webView.loadHTMLString(errorString, baseURL: URL.init(string: Bundle.main.path(forResource: url, ofType: "html")!));
            webView.load(URLRequest.init(url: URL.init(fileURLWithPath: Bundle.main.path(forResource: "NetworkError", ofType: "html")!)))

        }
        
    }
    
    
    func editWebData(){
        let request = URLRequest.init(url: URL.init(string: url)!)
        let session = URLSession.shared
        session.dataTask(with: request) { (data, res, err) in
            DispatchQueue.main.async {
                var str = String.init(data: data!, encoding: .utf8)
                let range1 = str?.range(of: "<a href=\"http://m.zhibo8.cc/download/\">更多新闻请下载直播吧客户端</a>")
                let range2 = str?.range(of: "<a href=\"http://m.zhibo8.cc/\">直播吧</a>")
                let range3 = str?.range(of: "<a class=\"float_right\" href=\"")
                            str = str?.replacingCharacters(in: range1!, with: "")
                            str = str?.replacingCharacters(in: range2!, with: "")
                            str = str?.replacingCharacters(in: range3!, with: "")
                //
                self.webView.loadHTMLString(str!, baseURL: URL.init(string: self.url))
            }
  
        }
    }
    
    func ads(){
        
        
        bannerView = GADBannerView.init(frame: CGRect(x: 0, y: naviHeight, width: WIDTH, height: 60))
        bannerView.backgroundColor = UIColor.white
        view.addSubview(bannerView)
        
        bannerView.adUnitID = "ca-app-pub-9033627101784845/4539885860"//ca-app-pub-9033627101784845/4539885860
        
        let request = GADRequest()
        request.testDevices = [ "5e9154e34ae2bda23a66973377c77859" ]
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.adSizeDelegate = self;
    }
    
    func adView(_ bannerView: GADBannerView, willChangeAdSizeTo size: GADAdSize) {
        print(size);
    }
    

//    
//    func addBannerViewToView(_ bannerView: GADBannerView) {
//        bannerView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(bannerView)
//        view.addConstraints(
//            [NSLayoutConstraint(item: bannerView,
//                                attribute: .bottom,
//                                relatedBy: .equal,
//                                toItem: bottomLayoutGuide,
//                                attribute: .top,
//                                multiplier: 1,
//                                constant: 0),
//             NSLayoutConstraint(item: bannerView,
//                                attribute: .centerX,
//                                relatedBy: .equal,
//                                toItem: view,
//                                attribute: .centerX,
//                                multiplier: 1,
//                                constant: 0)
//            ])
//    }
    
    func goBackWeb(){
        if webView.canGoBack {
            webView.goBack()
        }else{
            self.navigationController?.popViewController(animated: true);
        }
    }
    
    
    func closeWeb(){
        self.navigationController?.popViewController(animated: true);
    }
    
    func refreshWeb(){
        webView.reload()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "title" {
            self.navigationItem.title = self.webView.title;
            
        }else if keyPath == "estimatedProgress" {
            progressView.setProgress(Float(webView.estimatedProgress), animated: true)
            if webView.estimatedProgress >= 1.0{
                progressView.setProgress(0.0, animated: false)
            }
        }
    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        if self.webView.canGoBack {
            self.closeBtn.isHidden = false;
        }else{
            self.closeBtn.isHidden = true;
        }
        
    }
    
    //! WKWeView在每次加载请求前会调用此方法来确认是否进行请求跳转
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print(navigationAction);
        let url = navigationAction.request.url
        if url?.scheme == "tel" {
            let num = (url!.absoluteString as NSString).substring(from: 4)
                UIApplication.shared.openURL(URL( string:"tel://" + num)!)
            decisionHandler(.cancel)
            return;
        }
        
        //判断是不是有效链接
        if(url?.scheme == "http" || url?.scheme == "https"){
            decisionHandler(WKNavigationActionPolicy.allow)
            return;
        }
        
        
        //跳转原生浏览器
        guard let string = url?.absoluteString else {
            return
        }
        UIApplication.shared.openURL(URL(string: string)!)
        
        decisionHandler(WKNavigationActionPolicy.cancel)
    }
    
    

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
    }
    
    //网址增加http
    func urlDetection(url:String)->String{
        
        let http = url.range(of: "http://")
        let https = url.range(of: "https://")
        
        if http == nil && https == nil {
            return "https://\(url)"
        }
        
        return url;
        
    }
    
    
    deinit {
        print("deinit")
        self.webView.removeObserver(self, forKeyPath: "title");
        self.webView.removeObserver(self, forKeyPath: "estimatedProgress");

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
}

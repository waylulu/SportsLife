//
//  HTWebViewViewController.swift
//  SportsLife
//
//  Created by seven on 2019/8/21.
//  Copyright © 2019 west. All rights reserved.
//

import UIKit
import WebKit

@objcMembers
class HTWebViewViewController: HTBaseViewController ,WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler{

    

    var webView = WKWebView()
    var userContent = WKUserContentController()
    var config = WKWebViewConfiguration.init()
    var progressView = UIProgressView()
    var progress = CGFloat()
    var url = String()
    var closeBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
        self.setWebUI()
        self.setProgressView()
        self.loadData()
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
        
        webView = WKWebView.init(frame: self.view.bounds, configuration: config);
        self.webView.navigationDelegate = self;
        self.webView.uiDelegate = self;
        self.view.addSubview(webView);
    }

    func loadData(){
        if url.contains("http://") || url.contains("https://"){
            webView.load(URLRequest.init(url: URL.init(string: url)!))

        }else{
            webView.loadHTMLString(url, baseURL: nil);
        }
        
    }
    
    
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
        
        //判断是不是网页
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

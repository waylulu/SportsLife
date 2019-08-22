//
//  HTWebViewViewController.swift
//  SportsLife
//
//  Created by seven on 2019/8/21.
//  Copyright © 2019 west. All rights reserved.
//

import UIKit
import WebKit

class HTWebViewViewController: HTBaseViewController {

    var webView = WKWebView()
    var userContent = WKUserContentController()
    var config = WKWebViewConfiguration.init()
    var progressView = UIProgressView()
    var progress = CGFloat()
    
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
        self.view.addSubview(webView);
    }

    func loadData(){
        webView.load(URLRequest.init(url: URL.init(string: "https://www.baidu.com")!))
        
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
    
    
    deinit {
        print("deinit")
        self.webView.removeObserver(self, forKeyPath: "title");
        self.webView.removeObserver(self, forKeyPath: "estimatedProgress");

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
}

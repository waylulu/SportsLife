//
//  HTQRErrorViewController.swift
//  SportsLife
//
//  Created by seven on 2019/8/23.
//  Copyright © 2019 west. All rights reserved.
//

import UIKit

class HTQRErrorViewController: HTBaseViewController {
    
    var resString = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
    }
    func configUI(){
        self.title = "扫描结果"
        self.view.backgroundColor = UIColor.white
        let textView = UITextView.init(frame: CGRect.init(x: 20, y: 0, width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.height))
        //将中文解码
        let str = resString.removingPercentEncoding
        textView.text = str
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.isEditable = false
        self.view.addSubview(textView)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}

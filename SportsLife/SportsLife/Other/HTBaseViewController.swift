//
//  HTBaseViewController.swift
//  SportsLife
//
//  Created by seven on 2019/8/13.
//  Copyright © 2019 west. All rights reserved.
//

import UIKit

@objcMembers
class HTBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if self.classForCoder != SportsTableViewController.self {
            let leftBtn = UIBarButtonItem.init(image: HTImage("Icon_Back").withRenderingMode(.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.popView))
            self.navigationItem.leftBarButtonItem = leftBtn;
        }
    }
    

    func popView(){
        self.navigationController?.popViewController(animated: true)
    }

    
}

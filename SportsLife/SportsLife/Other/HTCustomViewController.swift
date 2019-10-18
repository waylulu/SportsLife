//
//  HTCustomViewController.swift
//  SportsLife
//
//  Created by seven on 2019/9/19.
//  Copyright © 2019 west. All rights reserved.
//

import UIKit

@objcMembers
class HTCustomViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    
    
    /**
     设置导航栏 状态栏
     
     -  barTintColor:  导航栏的背景色
     -  tintColor: 导航栏左右按钮颜色
     -  isTranslucent:    透明度
     -  default:    导航栏中状态栏文字是否显示白色的 default  黑色
     */
    
    func setDefaultNavigationController(){
        
        //导航栏的背景色与标题设置
        self.navigationBar.barStyle = UIBarStyle.default
        self.navigationBar.barTintColor = UIColor.white
        self.navigationBar.isTranslucent = false
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.gray,NSAttributedString.Key.font:UIFont.systemFont(ofSize:17)]
        
    }
    

//    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
//
//        if self.children.count > 0 {
//
//            viewController.tabBarController?.tabBar.isHidden=true
//            //导航栏返回按钮自定义
//            let backButton = UIButton(frame:CGRect.init(x:0, y: 0, width: 30, height: 40))
//            if #available(iOS 11.0, *) {
//                backButton.imageEdgeInsets = UIEdgeInsets(top: 0,left: -15*UIScreen.main.bounds.width/375,bottom: 0,right: 0)
//            }
//            backButton.setImage(UIImage.init(named:"Icon_Back"), for: UIControl.State.normal)
//            backButton.addTarget(self, action:#selector(self.popView), for: UIControl.Event.touchUpInside)
//            //            backButton.sizeToFit()
//            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView:backButton)
//        }
//        self.setDefaultNavigationController()
//        self.pushViewController(viewController, animated: true)
//    }

    func popView(){
        self.navigationController?.popViewController(animated: true)
    }
}

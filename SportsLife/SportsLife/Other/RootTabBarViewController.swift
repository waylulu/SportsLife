//
//  RootTabBarViewController.swift
//  SportsLife
//
//  Created by WTW on 2018/6/21.
//  Copyright © 2018年 west. All rights reserved.
//

import UIKit

class RootTabBarViewController: UITabBarController {

    var defaultImageArr = ["新闻2","视频2","数据2","我的2"]
    var selectImageArr  = ["新闻1","视频1","数据1","我的1"]
    var viewControllerArr = [SportsTableViewController(),ShopCollectionViewController(),HTRankBaseViewController(),MineTableViewController()]
    var titleArr = ["首页","视频","数据","设置"]
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configUI()
    }

    func configUI() {
        let layout = UICollectionViewFlowLayout.init()
        let shopVC = ShopCollectionViewController.init(collectionViewLayout: layout)
        //使用collectionView时要加layout不然会crash
        let one = self.setController(viewController: SportsTableViewController())
        let two = self.setController(viewController: ShopCollectionViewController.init(collectionViewLayout: UICollectionViewFlowLayout()))
        let three = self.setController(viewController: HTRankBaseViewController())
        let four = self.setController(viewController: MineTableViewController())
        self.viewControllers = [one,
                                two,
                                three,
                                four
                                ]
        
        one.title = "首页"
        two.title = "视频"
        three.title = "数据"
        four.title = "设置"

        self.setTabBarTitleColorAndTabBarImage(na: one, defaultColor: .black, selectColor: .red, defaultImageString: "新闻2", selectImageString: "新闻1")
        self.setTabBarTitleColorAndTabBarImage(na: two, defaultColor: .black, selectColor: .red, defaultImageString: "视频2", selectImageString: "视频1")
        self.setTabBarTitleColorAndTabBarImage(na: three, defaultColor: .black, selectColor: .red, defaultImageString: "数据2", selectImageString: "数据1")
        self.setTabBarTitleColorAndTabBarImage(na: four, defaultColor: .black, selectColor: .red, defaultImageString: "我的2", selectImageString: "我的1")
        
//        for i in 0..<self.viewControllerArr.count {
//            self.viewControllerArr[i].tabBarItem = UITabBarItem.init(title: self.titleArr[i], image: UIImage.init(named: self.defaultImageArr[i])?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage.init(named: self.selectImageArr[i])?.withRenderingMode(.alwaysOriginal))
//
//            self.viewControllerArr[i].tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.red], for: .selected)
//            self.viewControllers?.append(UINavigationController.init(rootViewController: self.viewControllerArr[i]))
//        }
//        self.navigationController?.viewControllers = self.viewControllers!;

    }
    
    func setController(viewController:UIViewController)  -> UINavigationController{
       return UINavigationController.init(rootViewController: viewController)
    }
    
    func setTabBarTitleColorAndTabBarImage(na:UINavigationController ,defaultColor:UIColor ,selectColor:UIColor , defaultImageString:String ,selectImageString:String) {
        
        na.tabBarItem.setTitleTextAttributes(NSDictionary.init(object:defaultColor, forKey: NSAttributedString.Key.backgroundColor as NSCopying) as? [NSAttributedString.Key : Any], for: UIControl.State.normal)
        na.tabBarItem.setTitleTextAttributes(NSDictionary.init(object:selectColor, forKey: NSAttributedString.Key.backgroundColor as NSCopying) as? [NSAttributedString.Key : Any], for: UIControl.State.selected)

        na.tabBarItem.image = UIImage.init(named: defaultImageString)?.withRenderingMode(.alwaysOriginal)
        na.tabBarItem.selectedImage = UIImage.init(named: selectImageString)?.withRenderingMode(.alwaysOriginal)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

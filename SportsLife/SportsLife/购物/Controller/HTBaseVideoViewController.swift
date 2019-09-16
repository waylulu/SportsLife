//
//  HTBaseVideoViewController.swift
//  SportsLife
//
//  Created by seven on 2019/9/3.
//  Copyright © 2019 west. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import SwiftyJSON

class HTBaseVideoViewController: ButtonBarPagerTabStripViewController {
    
    var titleArr = [["西甲","6"],["英超","4"],["德甲","3"],["意甲","5"],["法甲","7"],["中超","9"],["欧冠","8"]]
    var popview:YTBubbleView!
    var packView:UIView!
    var chooseYearBlock:ChooseYearCallback?
    weak var chooseYearDelagate:YearDelegate?
    var year = "2019"
    
    override func viewDidLoad() {
        self.setPageView()
        super.viewDidLoad()
        self.configUI()
        
    }
    
    
    func configUI(){
        self.navigationItem.title = "视频"
        self.buttonBarView.frame = CGRect(x: 0, y: naviHeight, width: WIDTH, height: 30)

    }
   
    
    func popViewDismiss() {
        self.packView.removeFromSuperview()
        //        self.popview.removeFromSuperview()
    }
    func setPageView(){
        // change selected bar color
        settings.style.buttonBarBackgroundColor = UIColor.white
        settings.style.buttonBarItemBackgroundColor = UIColor.clear
        settings.style.selectedBarBackgroundColor = UIColor.orange//滑动线颜色
        settings.style.buttonBarItemFont = UIFont(name: "HelveticaNeue-Light", size:14) ?? UIFont.systemFont(ofSize: 14)
        //        settings.style.buttonBarItemFont = HTFont(14, "")
        settings.style.selectedBarHeight = 3.0
        settings.style.buttonBarMinimumLineSpacing = 10
        settings.style.buttonBarItemTitleColor = .red
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarHeight = naviHeight
        
        //        settings.style.buttonBarLeftContentInset = 15
        //        settings.style.buttonBarRightContentInset = 15
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = UIColor.black
            newCell?.label.textColor = .orange
            oldCell?.backgroundColor = UIColor.white
            
        }
        self.view.backgroundColor = UIColor.white
        
    }
    
    
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        var arr = [HTVideoViewController]()
        for i in titleArr {
            let vc = HTVideoViewController()
            vc.league = i.last ?? "3"
            vc.itemTitle.title = i.first ?? "德甲"
            arr.append(vc)
        }
        return arr;
    }
}

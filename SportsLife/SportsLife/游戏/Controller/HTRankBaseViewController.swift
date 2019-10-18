//
//  HTRankBaseViewController.swift
//  SportsLife
//
//  Created by seven on 2019/8/29.
//  Copyright © 2019 west. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import SwiftyJSON

typealias  ChooseYearCallback = (_ year:String)->()

protocol YearDelegate:NSObjectProtocol{
    func chooseyear(_ yaer: String, _ league:String,_ tab:String)
}

@objcMembers
class HTRankBaseViewController: ButtonBarPagerTabStripViewController {

    var titleArr = ["西甲","英超","德甲","意甲","法甲","荷甲","中超","中甲"]
    var popview:YTBubbleView!
    var packView:UIView!
    var chooseYearBlock:ChooseYearCallback?
    weak var chooseYearDelagate:YearDelegate?
    var year = "2019"
    var pickView = UIPickerView()
    
    override func viewDidLoad() {
        self.setPageView()
        super.viewDidLoad()
        self.configUI()

    }
    
    
    func configUI(){
        self.navigationItem.title =  year + " - \(String(describing: Int(year)! + 1))" + "赛季"
        self.buttonBarView.frame = CGRect(x: 0, y: naviHeight, width: WIDTH, height: 30)
        
        let r = UIBarButtonItem.init(title: "赛季", style: .plain, target: self, action: #selector(rClick))
        self.navigationItem.rightBarButtonItem = r;
        
//        let l = UIBarButtonItem.init(title: "赛程", style: .plain, target: self, action: #selector(lClick))
//        self.navigationItem.leftBarButtonItem = l;
//        self.chooseYearDelagate = self;
        
    }
    func rClick(){
        self.packView = UIView.init(frame: UIScreen.main.bounds)
        self.packView.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 0, alpha: 0.3)
        let tap:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(popViewDismiss))
        self.packView.addGestureRecognizer(tap)
        keyWindow.addSubview(self.packView)
//
        self.popview = YTBubbleView.init(frame:CGRect(x: WIDTH - 314 * scaleWidth, y: naviHeight, width: 300 * scaleWidth, height: CGFloat(textArr.count * 65) * scaleHeight + 15))
        self.popview.backgroundColor = UIColor.clear
        self.popview.popItemAction = {[weak self] index in
            if self?.chooseYearDelagate != nil {
                self?.navigationItem.title =  index + " - \(String(describing: Int(index)! + 1))" + "赛季"
                self?.year = index
                self?.chooseYearDelagate?.chooseyear(index, self?.titleArr[self?.currentIndex ?? 0] ?? "西甲", "积分榜")
                self?.reloadPagerTabStripView()
            }
            
            self?.popViewDismiss()
            
            
        }
        self.packView.addSubview(self.popview)
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
        settings.style.buttonBarMinimumLineSpacing = 5
        settings.style.buttonBarItemTitleColor = .red
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarHeight = naviHeight
        
        //        settings.style.buttonBarLeftContentInset = 15
        //        settings.style.buttonBarRightContentInset = 15
        changeCurrentIndexProgressive = {/*[weak self]*/ (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = UIColor.black
            newCell?.label.textColor = .orange
            oldCell?.backgroundColor = UIColor.white
//            self!.navigationItem.title = self?.currentIndex == 0 ? self?.navigationItem.title : (self!.titleArr[(self?.currentIndex)!]) + self!.year + " - \(String(describing: Int(self!.year)! + 1))" + "赛季"

        }
        self.view.backgroundColor = UIColor.white
        
    }


    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        var arr = [HTRankViewController]()
        for i in titleArr {
            let vc = HTRankViewController()
            self.chooseYearDelagate = vc
            vc.league = i
            vc.itemTitle.title = i
            vc.year = self.year
            arr.append(vc)
        }
        return arr;
    }
}

extension HTRankBaseViewController{

    func lClick(){
//        let vc = PresentChooseViewController()
//        vc.modalPresentationStyle = .custom//蒙版风格overCurrentContext:tabbar跳转,custom
//        vc.modalTransitionStyle = .crossDissolve;//跳转的风格
//        self.presentingViewController?.definesPresentationContext = true;
//        //        self.tabBarController?.tabBar.isHidden = true;
//        vc.cardType = .one
//        vc.centerTitle = "选择展示的内容"
//
////        if (self.defaultPayData != nil) && cell?.detailTextLabel?.text == self.defaultPayData?.payType{
////            vc.choosePayData =  self.defaultPayData
////            vc.cardType = .more
////        }else if defaultData != nil && cell?.detailTextLabel?.text == self.defaultData?.model.title{
////            vc.choosePayData =  self.defaultData
////            vc.cardType = .one
////        }
////
//        self.present(vc, animated: true) {
//        }
//        //type = ""时是其他选择.不等于""是选择了支付方式
//        vc.choosePayTypeBlock = {[weak self] type ,model in
//            if self?.chooseYearDelagate != nil {
//                self?.navigationItem.title =  type + " - \(String(describing: Int(type)! + 1))" + "赛季"
//                self?.year = type
//                self?.chooseYearDelagate?.chooseyear(type, self?.titleArr[self?.currentIndex ?? 0] ?? "西甲")
//                self?.reloadPagerTabStripView()
//            }
//        }
        if self.chooseYearDelagate != nil {
            self.chooseYearDelagate?.chooseyear("2019", self.titleArr[self.currentIndex ], "赛程" )
            self.reloadPagerTabStripView()
        }
    }
    
    

}

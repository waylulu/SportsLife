//
//  HTRankBaseViewController.swift
//  SportsLife
//
//  Created by seven on 2019/8/29.
//  Copyright © 2019 west. All rights reserved.
//

import UIKit
import XLPagerTabStrip

typealias  ChooseYearCallback = (_ year:String)->()

protocol YearDelegate:NSObjectProtocol{
    func chooseyear(_ yaer: String, _ league:String)
}

@objcMembers
class HTRankBaseViewController: ButtonBarPagerTabStripViewController {

    var titleArr = ["西甲","英超","德甲","意甲","法甲","荷甲","中超","中甲"]
    var popview:YTBubbleView!
    var packView:UIView!
    var chooseYearBlock:ChooseYearCallback?
    weak var chooseYearDelagate:YearDelegate?
    
    override func viewDidLoad() {
        self.setPageView()
        super.viewDidLoad()
        self.configUI()

    }
    
    
    func configUI(){
        self.title = "2019"
        self.buttonBarView.frame = CGRect(x: 0, y: naviHeight, width: WIDTH, height: 30)
        let r = UIBarButtonItem.init(title: "赛季", style: .plain, target: self, action: #selector(rClick))
        self.navigationItem.rightBarButtonItem = r;
        
//        self.chooseYearDelagate = self;
        
    }
    func rClick(){
        self.packView = UIView.init(frame: UIScreen.main.bounds)
        self.packView.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 0, alpha: 0.3)
        let tap:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(popViewDismiss))
        self.packView.addGestureRecognizer(tap)
        keyWindow.addSubview(self.packView)
//
        self.popview = YTBubbleView.init(frame:CGRect(x: WIDTH - 314 * scaleWidth, y: naviHeight, width: 300 * scaleWidth, height: CGFloat(titleArr.count * 60) * scaleHeight))
        self.popview.backgroundColor = UIColor.clear
        self.popview.popItemAction = {[weak self] index in
//            print(index)
//            let vc = GamesTableViewController()
//            vc.year = index
//            vc.loadData(year: index)

            if self?.chooseYearDelagate != nil {
                self?.title = index
                self?.chooseYearDelagate?.chooseyear(index, self?.titleArr[self?.currentIndex ?? 0] ?? "西甲")
        }
//            if  self?.chooseYearBlock != nil {
//                self?.chooseYearBlock!(index)
//            }
            
//            switch index {
//            case 0://添加好友
////                let view = SearchFriendAndGruopViewController()
////                view.type = "好友"
////                view.hidesBottomBarWhenPushed = true
////                self.navigationController?.pushViewController(view, animated: true)
//                                print("haoyou")
//
//                break
//            case 1://查找群组
////                let view = SearchFriendAndGruopViewController()
////                view.type = "查找群组"
////                view.hidesBottomBarWhenPushed = true
////                self.navigationController?.pushViewController(view, animated: true)
//                print("查找群组")
//                break
//            case 2://扫一扫
////                let view = QRCode()
////                view.type = "扫一扫"
////                view.hidesBottomBarWhenPushed = true
////                self.navigationController?.pushViewController(view, animated: true)
//
//                break
//            default://创建群
//                //                let create = CreateGruopViewController()
//                //                let create = GroupManngerTableViewController()
//                //                create.hidesBottomBarWhenPushed = true
//                //                create.groupType = .CreateGroup
//                //                self.navigationController?.pushViewController(create, animated: true)
////                let vc = QQGCreateGroupViewController()
////                vc.hidesBottomBarWhenPushed = true
////                self.navigationController?.pushViewController(vc, animated: true)
//                print("创建群")
//                break
//            }
            
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
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = UIColor.black
            newCell?.label.textColor = .orange
            oldCell?.backgroundColor = UIColor.white
            
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
            vc.year = self.title ?? "2019"
            arr.append(vc)
        }
        return arr;
    }
}

extension HTRankBaseViewController{
//    func chooseyear(_ yaer: String) {
//        print(yaer)
//    }
    
    
}

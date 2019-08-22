//
//  PresentChooseViewController.swift
//  SportsLife
//
//  Created by seven on 2019/8/1.
//  Copyright © 2019 west. All rights reserved.
//

typealias ChoosePayTypeBlock = (_ payType:String,_ model:CardsModel)->()

import UIKit

@objcMembers
class PresentChooseViewController: UIViewController ,UIGestureRecognizerDelegate{
    
    var sourceView = UIView()
    var tableView = UITableView()
    
    var dataArr = NSMutableArray()
    
    var arrArr = NSMutableArray()
    var leftBtn = UIButton()
    var rightBtn = UIButton()
    
    var cardType = CradType.defalut
    
    var isChoose:Bool = false;
    
    var model = PresentDataModel()
    
    var btnBGView = ChooseTypeHeaderView()
    
    var centerTitle = "我是标题"
    
    var choosePayTypeBlock:ChoosePayTypeBlock?
    
    var choosePayData:(payType:String,model:CardsModel)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadData()
        self.configUI()

    }
    
    func configUI(){
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)//蒙版
        sourceView.backgroundColor = UIColor.white;
        self.view.addSubview(sourceView);
//        self.view.addSubview(self.leftBtn);
//        self.view.addSubview(rightBtn);
        self.view.addSubview(btnBGView)
        self.view.addSubview(tableView)
        
        tableView.delegate = self;
        tableView.dataSource = self;
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.register(ChooseTypeTableViewCell.self, forCellReuseIdentifier: "chooseCell")
        self.tableView.backgroundColor = UIColor.white
//        self.leftBtn.setTitle("取消", for: UIControl.State.normal)
//        self.leftBtn.setTitleColor(UIColor.gray, for: UIControl.State.normal)
//        self.leftBtn.addTarget(self, action: #selector(cancelBtn(sender:)), for: UIControl.Event.touchUpInside)
//        leftBtn.isHidden = self.cardType == .one ? true : false
//        self.rightBtn.setTitle(self.cardType == .more ? "确定" : "取消" , for: UIControl.State.normal)
//        self.rightBtn.setTitleColor(self.cardType == .more ? UIColor.red : UIColor.gray, for: UIControl.State.normal)
//        self.rightBtn.addTarget(self, action: #selector(chooseBtn(sender:)), for: UIControl.Event.touchUpInside)
        
        self.btnBGView.rightBtn.setTitle(self.cardType == .one ? "取消" : "确定", for: UIControl.State.normal)
        self.btnBGView.rightBtn.setTitleColor(self.cardType == .one ? UIColor.gray : UIColor.red , for: UIControl.State.normal)
        self.btnBGView.leftBtn.isHidden = self.cardType == .one ? true : false
        
        view.isUserInteractionEnabled = true
        let backTap = UITapGestureRecognizer.init(target: self, action: #selector(self.popView(gestrue:)))
        backTap.delegate = self;
        view.addGestureRecognizer(backTap)
    }
    
    
    
    func loadData(){

        self.cardType = self.cardType == .defalut ? arc4random() % 2 == 1 ? CradType.one : CradType.more : self.cardType
        
        cellHeight = self.cardType == .one ? 50 : 40;
        
//        if self.cardType == .one {
//            self.dataArr = [["a":"frist"],["a":"secend"],["a":"third"],["a":"forth"]]
//
//        }else{
//            self.dataArr = [["title":"银行卡", "detail" : [["a":"frist"],["a":"secend"]]],["title":"支付宝", "detail" : [["a":"frist"],["a":"secend"]]],["title":"微信", "detail" : [["a":"frist"],["a":"secend"]]]]
//
//            for dic in self.dataArr {
//                if ((dic as? NSDictionary) != nil) {
//                    let arr = (dic as? NSDictionary)!["detail"]
//
//                    if ((arr as? Array<[String:String]>) != nil){
//                        for dict in (arr as? Array<[String:String]>)! {
//                            self.arrArr.add(dict)
//                        }
//
//                    }
//                }
//            }
//        }
        
//        let sourceViewY = (self.cardType == .one ? HEIGHT -  cellHeight * CGFloat(self.dataArr.count) - headerHeight : (HEIGHT -  headerHeight * CGFloat(self.dataArr.count) - headerHeight - cellHeight * CGFloat(self.arrArr.count))) - bottomHeight;
//
//        let sourceViewHeight = (self.cardType == .one ? cellHeight * CGFloat(self.dataArr.count) + headerHeight : (cellHeight * CGFloat(self.dataArr.count) + headerHeight + cellHeight * CGFloat(arrArr.count))) + bottomHeight;
        
        
        
        self.model.cardModelArr.removeAll()
        self.model.cardTypeModelArr.removeAll()
        self.arrArr.removeAllObjects()
        
        self.model.getCardsdData()
        self.model.getPayTypesData()
        self.model.jsonTest()

        //获取所有内容
        if self.cardType == .more {
            for typeModel in self.model.cardTypeModelArr {
                for cardModel in typeModel.detail{
                    self.arrArr.add(cardModel)
                }
            }
        }
        
        let sourceViewY = (self.cardType == .one ? HEIGHT -  cellHeight * CGFloat(self.model.cardModelArr.count) - headerHeight : (HEIGHT -  headerHeight * CGFloat(self.model.cardTypeModelArr.count) - headerHeight - cellHeight * CGFloat(self.arrArr.count))) - bottomHeight;
        
        let sourceViewHeight = (self.cardType == .one ? cellHeight * CGFloat(self.model.cardModelArr.count) + headerHeight : (cellHeight * CGFloat(self.model.cardTypeModelArr.count) + headerHeight + cellHeight * CGFloat(arrArr.count))) + bottomHeight;
        
        
        tableView = UITableView.init(frame: CGRect(x: 0, y: sourceViewY + headerHeight, width: WIDTH, height: sourceViewHeight - headerHeight), style:.grouped)
        sourceView = UIView.init(frame: CGRect.init(x: 0, y: sourceViewY, width: WIDTH, height: sourceViewHeight));
        
//        leftBtn = UIButton.init(frame: CGRect(x: 0, y: sourceViewY, width: btnWidth, height: headerHeight))
//        rightBtn = UIButton.init(frame: CGRect(x: WIDTH - 80, y: sourceViewY, width: btnWidth, height: headerHeight))
        
        
        btnBGView = ChooseTypeHeaderView.init(frame: CGRect(x: 0, y: sourceViewY, width: WIDTH, height: headerHeight), leftBtnTitle: "取消", centerTitle: centerTitle, rightBtnTitle: "确定")

        btnBGView.cancalClick = { str in
            self.dismissView()
        }
        
        btnBGView.confirmClick = { str in
            self.confirm(string: str)
        }
    }

    
    //手势和tableview的selectc冲突
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
//        print(touch.view?.classForCoder)//UITableViewCellContentView没有这个类所以要通过父试图判断
//        print(UITableViewCell.classForCoder()

        if touch.view?.classForCoder == UITableViewCell().classForCoder || touch.view?.superview?.classForCoder == UITableViewCell().classForCoder  || touch.view?.superview?.superview?.classForCoder == UITableViewCell().classForCoder || touch.view?.classForCoder == ChooseTypeTableViewCell().classForCoder || touch.view?.superview?.classForCoder == ChooseTypeTableViewCell().classForCoder  || touch.view?.superview?.superview?.classForCoder == ChooseTypeTableViewCell().classForCoder || touch.view?.superview?.classForCoder == UITableView().classForCoder{
            return false
        }
        if touch.view?.superview?.classForCoder == UITableViewCell().classForCoder {
            return false
        }
        return true
    }
    //手势事件
    func popView(gestrue:UITapGestureRecognizer) {
        self.dismissView()
    }
    
    //dismiss
    func dismissView() {
        self.dismiss(animated: false, completion: {
        })
    }
    
    
//    func chooseBtn(sender:UIButton){
//        print(sender.currentTitle ?? "")
//        self.confirm(string: sender.currentTitle ?? "")
//    }
//
//    func cancelBtn(sender:UIButton){
//        self.dismissView()
//    }
    
    func confirm(string:String){

        if string == "确定" {
            if self.choosePayTypeBlock != nil{
                if self.choosePayData != nil {
                    AlertView.shard.MBProgressHUDWithMessage(message: string);
                    self.choosePayTypeBlock!(self.choosePayData!.payType, self.choosePayData!.model)
                }else{
                    AlertView.shard.MBProgressHUDWithMessage(message: "未选择");
                }
            }
        }else{
            AlertView.shard.MBProgressHUDWithMessage(message: string);

        }
        self.dismissView()

    }
    
    deinit {
        self.btnBGView.removeFromSuperview()

    }
    
}
extension PresentChooseViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
//        return  self.cardType == .one ? 1 : self.dataArr.count
        return  self.cardType == .one ? 1 : self.model.cardTypeModelArr.count

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        if self.cardType == .more {
//            for dic in self.dataArr {
//                let arr = ((dic as! NSDictionary)["detail"])
//                return (arr as? Array<[String:String]>)!.count
//            }
//        }
//        return self.dataArr.count

        if self.cardType == .more {

            return model.cardTypeModelArr[section].detail.count
        }

        return self.model.cardModelArr.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: WIDTH, height: headerHeight))
        
        
        let imageView = UIImageView.init(frame: CGRect(x: 30, y: (40 - 15 ) / 2 , width: 15, height: 15))
        imageView.contentMode = .scaleToFill
        view.addSubview(imageView)
        
        
        let label = UILabel.init(frame: CGRect(x: 20 + 30 + 10, y: 0, width: WIDTH - 20 - 30 - 10, height: headerHeight))
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.black;
        view.addSubview(label)
        
        
        if self.cardType == .more {
            imageView.image = UIImage.init(named: self.model.cardTypeModelArr[section].headerImage)
            label.text = self.model.cardTypeModelArr[section].title
        }
  
        return self.cardType == .one ? nil : view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return  self.cardType == .one ? 0.001 : headerHeight
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ChooseTypeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "chooseCell", for: indexPath) as! ChooseTypeTableViewCell
        //            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if self.cardType == .one {
//            cell.textLabel?.text = (self.dataArr[indexPath.row] as! Dictionary)["a"]
            let model = self.model.cardModelArr[indexPath.row]
//            cell.textLabel?.text = model.title
//            cell.textLabel?.textColor = model.isChoose == true ? UIColor.red : UIColor.black
//            cell.imageView?.image = UIImage.init(named:model.titleImage )
//            cell.detailTextLabel?.text = model.detail
//            cell.imageView?.image =  model.isChoose == true ? UIImage.init(named: "choose") :  UIImage.init(named: "")
            cell.setData(type: self.cardType, model: self.choosePayData?.model.title == model.title ? self.choosePayData!.model : model)
//            return cell
        }else{
//            let arr =  ((self.dataArr[indexPath.section] as! NSDictionary)["detail"])
//            let dic = (arr as? Array<[String:String]>)![indexPath.row]
//            cell.textLabel?.text = dic["a"]
            let baseModel = self.model.cardTypeModelArr[indexPath.section]
            let model =  self.model.cardTypeModelArr[indexPath.section].detail[indexPath.row]
//            cell.textLabel?.text = model.title;
//            cell.imageView?.image =  model.isChoose == true ? UIImage.init(named: "choose") :  UIImage.init(named: "")
//            cell.imageView?.contentMode = .scaleToFill
//            cell.detailTextLabel?.text = model.detail
            cell.setData(type: cardType, model: self.choosePayData?.payType == baseModel.title ? self.choosePayData?.model.title == model.title ? self.choosePayData!.model : model : model)
//            return cell
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        let cell = tableView.cellForRow(at: indexPath)
        if self.cardType == .one {
            for i in 0..<self.model.cardModelArr.count{
                if i == indexPath.row {
                    self.model.cardModelArr[i].isChoose = true
                    if self.choosePayTypeBlock != nil{
                        self.choosePayTypeBlock!("", self.model.cardModelArr[i])
                    }
                    self.dismissView()
                }else{
                    self.model.cardModelArr[i].isChoose = false
                }
                
            }
        }else{
//            let model =  self.model.cardTypeModelArr[indexPath.section].detail[indexPath.row]
            for i in 0..<self.model.cardTypeModelArr.count {
                for j in 0..<self.model.cardTypeModelArr[i].detail.count{
                    if i == indexPath.section && j == indexPath.row {
                        self.model.cardTypeModelArr[i].detail[j].isChoose = true
                        self.choosePayData = (self.model.cardTypeModelArr[i].title,self.model.cardTypeModelArr[i].detail[j])
                    }else{
                        self.model.cardTypeModelArr[i].detail[j].isChoose = false
                    }
                }
            }
            
        }
        
        self.tableView.reloadData()
    }
   

}

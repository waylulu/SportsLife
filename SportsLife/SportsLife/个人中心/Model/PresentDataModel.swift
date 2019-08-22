//
//  PresentDataModel.swift
//  SportsLife
//
//  Created by seven on 2019/8/2.
//  Copyright © 2019 west. All rights reserved.
//

import UIKit
import SwiftyJSON
class PresentDataModel {

    var  cardModelArr = [CardsModel]()
    
    var cardTypeModelArr = [PayTypeModel]()
    

    
    let arr = [["title":"frist","detail":"1","titleImage":"a","isChoose":false],["title":"secend","detail":"2","titleImage":"b","isChoose":false],["title":"third","detail":"3","titleImage":"c","isChoose":false],["title":"forth","detail":"4","titleImage":"d","isChoose":false]];
    
   
    func getCardsdData(){
        for dic in arr {
            self.cardModelArr.append(CardsModel.init(json: JSON.init(dic)))
        }
    }
    let payArr = [["title":"银行卡","headerImage":"a", "detail" : [["title":"14122434235235","detail":"中国银行","titleImage":"a","isChoose":false],["title":"3525253252353252525252","detail":"招商银行","titleImage":"b","isChoose":false]]],["title":"支付宝","headerImage":"c", "detail" : [["title":"124141411@qq.com","detail":"2","titleImage":"c","isChoose":false]]],["title":"微信","headerImage":"d", "detail" : [["title":"13211111111","detail":"2","titleImage":"d","isChoose":false]]]]
    
    func getPayTypesData(){
        
        for dict in payArr {
            self.cardTypeModelArr.append(PayTypeModel.init(json: JSON.init(dict)))
        }
    }
    
    func jsonTest(){
        print(HelperClass.shared.dicArrayToJson(arr as [[String : AnyObject]]))
        print(HelperClass.shared.dicArrayToJson(payArr as [[String : AnyObject]]))
        print(HelperClass.shared.arrayToJson(arr as AnyObject))
    }
    
//    self.dataArr = [["title":"银行卡", "detail" : [["title":"frist"],["title":"secend"]]],["title":"支付宝", "detail" : [["title":"frist"],["title":"secend"]]],["title":"微信", "detail" : [["title":"frist"],["title":"secend"]]]]

    
    
}

//
//  HTLanguageDataModel.swift
//  SportsLife
//
//  Created by seven on 2020/4/23.
//  Copyright © 2020 west. All rights reserved.
//

import UIKit
import SwiftyJSON
class HTLanguageDataModel: NSObject {

    
    func getLanguageData(completion:([HTLanguageModel])->Void){
        var dataArr = [HTLanguageModel]()
        let data = [["language":"简体中文","type":"zh-Hans"],["language":"English","type":"en"],["language":"日本語","type":"ja"]];
        for i in data {
            var model = HTLanguageModel(json: JSON.null)
            model.title = i["language"] ?? ""
            model.detail = i["type"] ?? ""
            dataArr.append(model);

        }
        completion(dataArr);
    }
    
    
}

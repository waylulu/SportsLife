//
//  HTLanguageModel.swift
//  SportsLife
//
//  Created by seven on 2020/4/23.
//  Copyright © 2020 west. All rights reserved.
//

import UIKit
import SwiftyJSON

struct HTLanguageModel {

    var title = "";
    var detail = "";
    init(json:JSON) {
        title = json["title"].stringValue;
        detail = json["detail"].stringValue;
    }
}

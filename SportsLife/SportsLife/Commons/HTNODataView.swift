//
//  HTNODataView.swift
//  SportsLife
//
//  Created by seven on 2019/9/3.
//  Copyright © 2019 west. All rights reserved.
//

import UIKit

class HTNODataView: UIView {

    var label = UILabel()
    var labelString = String()
    convenience init(frame:CGRect,titleString:String) {
        self.init(frame: frame)
        self.labelString = titleString;
        self.configUI()
    }
    func configUI(){
        self.label.frame = self.frame
        self.label.textAlignment = .center
        self.label.text = labelString
        self.addSubview(label);
    }
    
    
}

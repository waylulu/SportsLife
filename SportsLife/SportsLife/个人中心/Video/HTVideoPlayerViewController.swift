//
//  HTVideoPlayerViewController.swift
//  SportsLife
//
//  Created by seven on 2019/10/21.
//  Copyright © 2019 west. All rights reserved.
//

import UIKit
import AVKit

class HTVideoPlayerViewController: HTBaseViewController {
    
    var player = AVPlayer()
    
    var playerItem:AVPlayerItem?
    
    var playerLayer = AVPlayerLayer()
    
    var videoUrl = ""
    
    
    
    var pauseOrPlayBtn = UIButton()
    
    var startTimelabel = UILabel()
    
    var totalTimeLabel = UILabel()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

   

}

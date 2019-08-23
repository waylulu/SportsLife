//
//  HTTestViewController.swift
//  SportsLife
//
//  Created by seven on 2019/8/23.
//  Copyright © 2019 west. All rights reserved.
//

import UIKit

class HTTestViewController: HTBaseViewController {

    var tableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
//        let label = UILabel.init(frame: CGRect.init(x: 0, y: 100, width: WIDTH, height: 40));
//        label.text = "\(arc4random())";
//        label.textAlignment = .center;
//        label.textColor = UIColor.red
//        self.view.addSubview(label);
        tableView = UITableView.init(frame: CGRect(x: 0, y: 100, width: WIDTH, height: 300), style: .plain);
        tableView.backgroundColor = BGColor
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
    }
    

    
}

extension HTTestViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60;
    }
    
}

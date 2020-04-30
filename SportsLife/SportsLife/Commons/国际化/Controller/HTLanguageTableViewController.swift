//
//  HTLanguageTableViewController.swift
//  SportsLife
//
//  Created by seven on 2020/4/23.
//  Copyright © 2020 west. All rights reserved.
//

import UIKit

class HTLanguageTableViewController: HTBaseTableViewController {

    var dataArr = [HTLanguageModel]();
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.tableView.register(TableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        let modelData = HTLanguageDataModel()
        modelData.getLanguageData { (data) in
            dataArr = data;
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataArr.count;
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let model = dataArr[indexPath.row];
        
        cell.textLabel?.text = model.title;
//        cell.detailTextLabel?.text = model.detail;
        if model.detail == HTLanguageHelper.shard.getCurrentLanguage() {
            cell.backgroundColor = UIColor.cyan;
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
        
        let model = dataArr[indexPath.row];
        
        AlertView().MBProgressHUDWithMessage(view: self.view, message: model.title);
        
//           [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:language, nil] forKey:@"AppleLanguages"];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//
//
//        // 我们要把系统windown的rootViewController替换掉
//            ZHTabBarController *tab = [[ZHTabBarController alloc] init];
//            [UIApplication sharedApplication].keyWindow.rootViewController = tab;
//            // 跳转到设置页
//            tab.selectedIndex = 2;
//        UserDefaults.standard.setValue(model.title, forKey: "APPLanguage");
        HTLanguageHelper.shard.setLanguage(langeuage: model.detail)
        UserDefaults.standard.synchronize()
        let rt = RootTabBarViewController ()
        UIApplication.shared.keyWindow?.rootViewController = rt;
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

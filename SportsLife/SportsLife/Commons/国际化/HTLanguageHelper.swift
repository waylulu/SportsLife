//
//  HTLanguageHelper.swift
//  SportsLife
//
//  Created by seven on 2020/4/23.
//  Copyright © 2020 west. All rights reserved.
//


import UIKit

let UserLanguage = "userLanguage"
let AppLanguages = "AppleLanguages"

class HTLanguageHelper: NSObject {

    static let shard = HTLanguageHelper();
    
    let userDedalut = UserDefaults.standard;
    
    var bundle : Bundle?
    
    func initLanguage() {
        var string:String = userDedalut.value(forKey: UserLanguage) as! String? ?? ""
        if string == "" {
            let languages = userDedalut.object(forKey: AppLanguages) as? NSArray
            if languages?.count != 0 {
                let current = languages?.object(at: 0) as? String
                if current != nil {
                    string = current!
                    userDedalut.set(current, forKey: UserLanguage)
                    userDedalut.synchronize()
                }
            }

        }
        string = string.replacingOccurrences(of: "-CN", with: "")
        string = string.replacingOccurrences(of: "-US", with: "")
        var path = Bundle.main.path(forResource:string , ofType: "lproj")
        if path == nil {
             path = Bundle.main.path(forResource:"en" , ofType: "lproj")
        }
        bundle = Bundle(path: path!)
    }

    func setLanguage(langeuage:String) {
        let path = Bundle.main.path(forResource:langeuage , ofType: "lproj")
        bundle = Bundle(path: path!)
        userDedalut.set(langeuage, forKey: UserLanguage)
        userDedalut.synchronize()
    }

    func getCurrentLanguage()->String{
        var string:String = userDedalut.value(forKey: UserLanguage) as! String? ?? ""
        if string == "" {
            let languages = userDedalut.object(forKey: AppLanguages) as? NSArray
            if languages?.count != 0 {
                let current = languages?.object(at: 0) as? String
                if current != nil {
                    string = current!
                    userDedalut.set(current, forKey: UserLanguage)
                    userDedalut.synchronize()
                }
            }

        }
        return string;
    }
}

var HTLanguageString:(String)->String = { str->String in
    let bundle = HTLanguageHelper.shard.bundle
    let str = bundle?.localizedString(forKey: str, value: nil, table: nil)

    return str ?? ""
}

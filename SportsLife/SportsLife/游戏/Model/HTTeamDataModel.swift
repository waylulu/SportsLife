//
//  HTTeamDataModel.swift
//  SportsLife
//
//  Created by seven on 2019/9/19.
//  Copyright © 2019 west. All rights reserved.
//

import UIKit
import SwiftyJSON

class HTTeamDataModel: NSObject {

    var info = teamInfo()
    var ranking = teamRanking()
    var tab = teamTab()
    var attention = teamAttention()
    var bbs = teamBbs()
    
    convenience init(json:JSON) {
        self.init()
        self.info = teamInfo.init(json: json["info"])
        self.ranking = teamRanking.init(json: json["ranking"])
        self.tab = teamTab.init(json: json["tab"])
        self.attention = teamAttention.init(json: json["attention"])
        self.bbs = teamBbs.init(json: json["bbs"])

    }
}


class teamInfo: NSObject {
    var alias = ""
    var country = ""
    var id = "623"
    var league = "西甲"
    var league_id = "36"
    var logo = "http"
    var name_cn = "塞维利亚"
    var name_en = "Sevilla"
    var short_name = "塞维利亚"
    var stadium = "皮斯胡安球场"
    var stadium_capacity = "43883"
    var type = "足球"
    
    convenience init(json:JSON) {
        self.init()
        self.alias = json["alias"].stringValue
        self.country = json["country"].stringValue
        self.id = json["id"].stringValue
        self.league = json["league"].stringValue
        self.league_id = json["league_id"].stringValue
        self.logo = json["logo"].stringValue
        self.name_cn = json["name_cn"].stringValue
        self.name_en = json["name_en"].stringValue
        self.short_name = json["short_name"].stringValue
        self.stadium = json["stadium"].stringValue
        self.stadium_capacity = json["stadium_capacity"].stringValue
        self.type = json["type"].stringValue

    }
}

class teamRanking: NSObject {
    var league = "西甲"
    var league_id = "36"
    var rank = "1"
    var season = "2019"

    convenience init(json:JSON) {
        self.init()
        self.league = json["league"].stringValue
        self.league_id = json["league_id"].stringValue
        self.rank = json["rank"].stringValue
        self.season = json["season"].stringValue

    }
}

class teamTab: NSObject {
    
    var position = ""
    var list = [teamTabDetail]()
    
    convenience init(json:JSON) {
        self.init()
        self.position = json["position"].stringValue
        for i in json["list"].arrayValue {
            self.list.append(teamTabDetail.init(json: i))
        }
    }
}

class teamTabDetail: NSObject {
    var api_url = "https"
    var key = "info"
    var mode = "json"
    var name = "资料"

    convenience init(json:JSON) {
        self.init()
        self.api_url = json["api_url"].stringValue
        self.key = json["key"].stringValue
        self.mode = json["mode"].stringValue
        self.name = json["name"].stringValue

        
    }
}

class teamAttention: NSObject {
    var status = ""
    var data = teamAttentionDetail()
    convenience init(json:JSON) {
        self.init()
        self.status = json["status"].stringValue
        self.data = teamAttentionDetail.init(json: json["data"])
    }
}

class teamAttentionDetail: NSObject {

    var focus = Bool()
    var id = "1_2_623"
    var key = "01_04_07"
    var alias = ""
    var country = ""
    var league = "西甲"
    var league_id = "36"
    var logo = "http"
    var name_cn = "塞维利亚"
    var name_en = "Sevilla"
    var short_name = "塞维利亚"
    var stadium = "皮斯胡安球场"
    var stadium_capacity = "43883"
    var type = "足球"
    
    convenience init(json:JSON) {
        self.init()
        self.focus = json["focus"].boolValue
        self.id = json["id"].stringValue
        self.key = json["key"].stringValue
        self.alias = json["alias"].stringValue
        self.country = json["country"].stringValue
        self.league = json["league"].stringValue
        self.league_id = json["league_id"].stringValue
        self.logo = json["logo"].stringValue
        self.name_cn = json["name_cn"].stringValue
        self.short_name = json["short_name"].stringValue
        self.stadium = json["stadium"].stringValue
        self.stadium_capacity = json["stadium_capacity"].stringValue
        self.type = json["type"].stringValue

    }
}

class teamBbs: NSObject {
    var status = ""
    var data = teamBbsDetail()
    convenience init(json:JSON) {
        self.init()
        self.status = json["status"].stringValue
        self.data = teamBbsDetail.init(json: json["data"])
    }
}
class teamBbsDetail: NSObject {
    
    convenience init(json:JSON) {
        self.init()
    }
}


let HtteamDataUrl:(_ id:String)->String = { id in
    return "https://db.qiumibao.com/f/zuqiu/team/base?device=iPhone11%2C8&time_zone=Asia/Shanghai&id=\(id)&appname=zhibo8&os=iOS&UDID=f9842ff0c21fc7e2e86133bd99bbddb21f463206&platform=ios&pk=com.zhibo8.tenyears&_platform=ios&version_code=4.8.4&os_version=12.4.1&usersports=1&blacks_status=enable&IDFA=2D6BD8E3-DA38-46B3-A4C4-749EF4F500F0"//球队数据
}



class HTTeamData: NSObject {
    func getTeamData(taemId:String, loadingView:UIView,callBack:@escaping ((HTTeamDataModel,JSON)->())){
        HTServices.htNet.getData(loadingView: loadingView, urlString: HtteamDataUrl(taemId), method: .get, parameters: [:]) {(json) -> (Void) in
            var taemData = [HTTeamDataModel]()
            
            if json["status"].stringValue == "1"{
    
                callBack(HTTeamDataModel.init(json: json["data"]), json)
                
            }else{
                callBack(HTTeamDataModel.init(),json)
            }
            
        }
    }
    
    func getInternalTeamData(dataApi:String, loadingView:UIView,callBack:@escaping ((internalDataModel,JSON)->())){
        
        HTServices.htNet.getData(loadingView: loadingView, urlString: dataApi, method: .get, parameters: [:]) {(json) -> (Void) in
            
            if json["status"].stringValue == "1"{
       
                callBack(internalDataModel.init(json: json["data"]), json)
                
            }else{
                callBack(internalDataModel.init(),json)
            }
            
        }
    }
    
    func getTeamInfoData(dataApi:String, loadingView:UIView,callBack:@escaping ((iteamInfoDataModel,JSON)->())){
           
           HTServices.htNet.getData(loadingView: loadingView, urlString: dataApi, method: .get, parameters: [:]) {(json) -> (Void) in
               
               if json["status"].stringValue == "1"{
          
                   callBack(iteamInfoDataModel.init(json: json["data"]), json)
                   
               }else{
                   callBack(iteamInfoDataModel.init(),json)
               }
               
           }
       }
       
    
    func getSquadData(dataApi:String, loadingView:UIView,callBack:@escaping ((squad,JSON)->())){
        HTServices.htNet.getData(loadingView: loadingView, urlString: dataApi, method: .get, parameters: [:]) { (json) -> (Void) in
                
           if json["status"].stringValue == "1"{
               callBack(squad.init(json: json["data"]), json)
               
           }else{
                callBack(squad.init(json: JSON.null),json)
           }
        }
        
    }
    
    
    func getScheduleData(dataApi:String, loadingView:UIView,callBack:@escaping ((schedule,JSON)->())){
        HTServices.htNet.getData(loadingView: loadingView, urlString: dataApi, method: .get, parameters: [:]) { (json) -> (Void) in
                
           if json["status"].stringValue == "1"{
               callBack(schedule.init(json: json["data"]), json)
               
           }else{
                callBack(schedule.init(json: JSON.null),json)
           }
        }
    }
    
    func getNewsData(dataApi:String, loadingView:UIView,callBack:@escaping ((newsModel,JSON)->())){
        
        HTServices.htNet.getData(loadingView: loadingView, urlString: dataApi.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "", method: .get, parameters: [:]) { (json) -> (Void) in
                print(dataApi)
            if json["status"].stringValue == "success"{
                callBack(newsModel.init(json: json["data"]), json)
                 
            }else{
                callBack(newsModel.init(json: JSON.null),json)
            }
        }
    }
    
    
    
}

//球队数据
class internalDataModel: NSObject {
    
    var iradar = [recordDataModel]()
    var record = recordDataModel()
    var data_king = data_kingDataModel()
    var standings = standingsDataModel()
    
    convenience init(json:JSON) {
        self.init()
        for i in json["iradar"].arrayValue {
            self.iradar.append(recordDataModel.init(json: i))
        }
        self.record = recordDataModel.init(json: json["record"])
        self.data_king = data_kingDataModel.init(json: json["data_king"])
        self.standings = standingsDataModel.init(json: json["standings"])
        
    }
}

class iradarDataModel: NSObject {
    var max     = "12"
    var subtext = ""
    var text    = "进球"
    var value   = "10"

    convenience init(json:JSON) {
        self.init()
        self.max = json["max"].stringValue
        self.subtext = json["subtext"].stringValue
        self.text = json["text"].stringValue
        self.value = json["value"].stringValue

    }
}
class recordDataModel: NSObject {
    
    var title = "球队记录"
    var list  = [recordTypeModel]()
    convenience init(json:JSON) {
        self.init()
        
        self.title = json["title"].stringValue
        
        for i in json["list"].arrayValue {
            self.list.append(recordTypeModel.init(json: i))
        }
        
    }
}

class recordTypeModel: NSObject {
    var title = ""
    var list = [playerDetailModel]()
    var show_more = morelDataModel()
    var data = [playerDetailModel]()
    var season = ""
    
    convenience init(json:JSON) {
        self.init()
        
        self.title = json["title"].stringValue
        
        for i in json["list"].arrayValue {
            self.list.append(playerDetailModel.init(json: i))
        }
        self.show_more = morelDataModel.init(json: json["show_more"])
        
        for i in json["data"].arrayValue {
            self.data.append(playerDetailModel.init(json: i))
        }
        
        self.season = json["season"].stringValue

    }
}

class playerDetailModel: NSObject {
    
    var avatar = "http"
    var player = "C罗"
    var player_id = "2289"
    var rank = "1"
    var value = "450进球"

    convenience init(json:JSON) {
        self.init()
        self.avatar    = json["avatar"].stringValue
        self.player    = json["player"].stringValue
        self.player_id = json["player_id"].stringValue
        self.rank      = json["rank"].stringValue
        self.value     = json["value"].stringValue

    }
}
class morelDataModel: NSObject {
    var mode = "web"
    var title = "查看更多"
    var url = "https"

    convenience init(json:JSON) {
        self.init()
        self.mode     = json["mode"].stringValue
        self.title     = json["title"].stringValue
        self.url     = json["url"].stringValue

    }

}


class data_kingDataModel: NSObject {
    var title = ""
    var season_options = [JSON]()
    var list = [recordTypeModel]()
    convenience init(json:JSON) {
        self.init()
        self.title = json["title"].stringValue
        self.season_options = json["season_options"].arrayValue
        for i in json["list"].arrayValue {
            self.list.append(recordTypeModel.init(json: i))
        }
    }
}



class standingsDataModel: NSObject {
    var title = ""
    var items_show = Bool()
    var items = [JSON]()
    var list = [JSON]()
    convenience init(json:JSON) {
        self.init()
        self.title = json["title"].stringValue
        self.items_show = json["items_show"].boolValue
        self.items = json["items"].arrayValue;
        self.list = json["list"].arrayValue;

    }
}


///资料
class iteamInfoDataModel: NSObject {
    
    var honor = honorModel()
    var intro = introModel()
    var transfers = transfersModel()
    var info = [infoModel]()
    convenience init(json:JSON) {
        self.init()
        self.honor = honorModel.init(json: json["honor"])
        self.intro = introModel.init(json: json["intro"])
        self.transfers = transfersModel.init(json: json["transfers"])
        for i in json["info"].arrayValue {
            self.info.append(infoModel.init(json: i))
        }
    }

}


class honorModel: NSObject {
    var title = ""
    var list = [honorDetail]()
    
    convenience init(json:JSON) {
        self.init()
        
        self.title = json["title"].stringValue
        for i in json["list"].arrayValue {
            self.list.append(honorDetail.init(json: i))
        }
    }

}

class honorDetail {
    
    var picture = ""
    var season = [JSON]()
    var honor = ""
    
    convenience init(json:JSON) {
        self.init()
        self.picture = json["picture"].stringValue
        self.season = json["season"].arrayValue
        self.honor = json["honor"].stringValue

    }
}


class introModel: NSObject {
    var title = ""
    var data = ""
    convenience init(json:JSON) {
        self.init()
        self.title = json["title"].stringValue
        self.data = json["data"].stringValue
        
    }

}
class transfersModel: NSObject {
    var title = ""
    var list = [transferModel]()
    var show_more = morelDataModel()
    var data = [playerDetailModel]()
    var season = ""
    
    convenience init(json:JSON) {
        self.init()
        
        self.title = json["title"].stringValue
        
        for i in json["list"].arrayValue {
            self.list.append(transferModel.init(json: i))
        }
        self.show_more = morelDataModel.init(json: json["show_more"])
        
        for i in json["data"].arrayValue {
            self.data.append(playerDetailModel.init(json: i))
        }
        
        self.season = json["season"].stringValue

    }
}



class transferModel: NSObject {
    var date = ""
    var fee = "1_2_623"
    var fee_new = "01_04_07"
    var from_team = ""
    var from_team_id = ""
    var from_team_logo = "西甲"
    var player = "36"
    var player_id = "http"
    var to_team = "塞维利亚"
    var to_team_id = "Sevilla"
    var to_team_logo = "塞维利亚"
    var type = "皮斯胡安球场"
      
    convenience init(json:JSON) {
        self.init()
        self.date = json["date"].stringValue
        self.fee = json["fee"].stringValue
        self.fee_new = json["fee_new"].stringValue
        self.from_team = json["from_team"].stringValue
        self.from_team_id = json["from_team_id"].stringValue
        self.from_team_logo = json["from_team_logo"].stringValue
        self.player = json["player"].stringValue
        self.player_id = json["player_id"].stringValue
        self.to_team = json["to_team_logo"].stringValue
        self.to_team_id = json["to_team_logo"].stringValue
        self.to_team_logo = json["to_team_logo"].stringValue
        self.type = json["type"].stringValue
    
    }
}


class infoModel: NSObject {
    var key = ""
    var value = ""
    convenience init(json:JSON) {
        self.init()
        self.key = json["key"].stringValue
        self.value = json["value"].stringValue
   
    }

}



///阵容
struct squad {
    var coaching_staff = coachsData(json: JSON.null)
    var squad = [squadsData]()
    init(json:JSON) {
        for i in json["squad"].arrayValue {
            squad.append(squadsData.init(json: i))
        }
        coaching_staff = coachsData.init(json: json["coaching_staff"])
    }
}


struct coachsData {
    var list = [coachInfo]()
    var show_more = morelDataModel()
    var title = ""
    init(json:JSON) {
        for i in json["list"].arrayValue {
            list.append(coachInfo.init(json: i))
        }
        show_more = morelDataModel.init(json: json["show_more"])
        title = json["title"].stringValue

    }
}

struct coachInfo {
    var name = ""
    var id  = ""
    var position = ""
    var redirect = redirectInfo(json: JSON.null)
    var avatar = ""
    init(json:JSON) {
        name = json["name"].stringValue
        id = json["id"].stringValue
        position = json["position"].stringValue
        avatar = json["avatar"].stringValue
        redirect = redirectInfo.init(json: json["redirect"])
    }
}


struct redirectInfo {
    var url = ""
    var mode = ""
    init(json:JSON) {
        url = json["url"].stringValue
        mode = json["mode"].stringValue

    }
}


struct squadsData {
    var list = [playerTypeInfo]()
    var title = ""
    init(json:JSON) {
        for i in json["list"].arrayValue {
            list.append(playerTypeInfo.init(json: i))
        }
        title = json["title"].stringValue
    }
}

struct playerTypeInfo {
    var transfer = transferData(json: JSON.null)
    var id = ""
    var avatar = ""
    var number = ""
    var injury = ""
    var assist = ""
    var name = ""
    var u23 = ""
    var goal = ""
    var captain = ""
    var position = ""
    init(json:JSON) {
        transfer = transferData.init(json: json["transfer"])
        id = json["id"].stringValue
        avatar = json["avatar"].stringValue
        number = json["number"].stringValue
        injury = json["injury"].stringValue
        assist = json["assist"].stringValue
        name = json["name"].stringValue
        u23 = json["u23"].stringValue
        goal = json["goal"].stringValue
        captain = json["captain"].stringValue
        position = json["position"].stringValue

    }
}


struct transferData {
    var id = ""
    var name = " "
    var logo = ""
    init(json:JSON) {
        id = json["id"].stringValue
        name = json["name"].stringValue
        logo = json["logo"].stringValue
    }
}




///赛程
struct schedule {
    var items = [JSON]()
    
    var data = [scheduleData]()
    
    var show_image = [show_imageData]()
    
    var redirect = [redirectData]()
    
    var position:Int = 0
    
    var model = ""
    
    var items_show:Int = 0
    
    init(json:JSON) {
        items = json["items"].arrayValue
        
        for i in json["data"].arrayValue {
            data.append(scheduleData.init(json: i))
        }
        
        for i in json["show_image"].arrayValue {
            show_image.append(show_imageData.init(json: i))
        }
        
        for i in json["redirect"].arrayValue {
            redirect.append(redirectData.init(json: i))
        }
        
        position = json["position"].intValue

        model = json["model"].stringValue

        items_show = json["items_show"].intValue

    }
}
///月份赛程
struct scheduleData {
    var title = ""
    var list = [schedeluitemData]()
    
    init(json:JSON) {
        title = json["title"].stringValue
        for i in json["list"].arrayValue {
            list.append(schedeluitemData.init(json: i))
        }
    }
}

struct schedeluitemData {
    var awayIcon = ""
    var awayName = ""
    var awayId = ""
    var homeIcon = ""
    var homwName = ""
    var homeId = ""
    var detailUrl = ""
    var date = ""
    var score = ""
    init(json:JSON) {
        awayIcon = json["客队图标"].stringValue
        awayName = json["客队"].stringValue
        awayId = json["awayId"].stringValue
        homeIcon = json["主队图标"].stringValue
        homwName = json["主队"].stringValue
        homeId = json["homeId"].stringValue
        detailUrl = json["内页"].stringValue
        date = json["日期"].stringValue
        score = json["比分"].stringValue
  
    }
}

struct show_imageData {
    var key = ""
    var img_index = ""
    var position = ""
    var img_key = ""
    init(json:JSON) {
        key = json["key"].stringValue
        img_index = json["img_index"].stringValue
        position = json["position"].stringValue
        img_key = json["img_key"].stringValue

    }
}

struct redirectData {
    var key = ""
    var url = ""
    var update = [JSON]()
    
    init(json:JSON) {
        key = json["key"].stringValue
        url = json["url"].stringValue
        
        update = json["updata"].arrayValue
    }
}



struct newsModel {
    var prev_date =  ""
    var list = [newsDetailModel]()
    init(json:JSON) {
        prev_date = json["prev_date"].stringValue
        for i in json["list"].arrayValue {
            list.append(newsDetailModel.init(json: i))
        }
    }
    
}
struct newsDetailModel{
     var color = ""
      var shortTitle = "阿利森：梅西是史上最佳之一，能三次战胜他是全队功劳"
      var from_url = "7851"
      var updatetime = "2019-10-14 00:11:07"
      var position = "首页小字区域二"
      var filename = "5da34c9bb6b93"
      var way = "2019_10_14-news-zuqiu-5da34c9bb6b93"
      var from_name = "利物浦回声报"
      var saishiid = "0"
      var porder = "4"
      var butuijian = "0"
      var indextitle = "阿利森：梅西是史上最佳之一，能三次战胜他是全队功劳"
      var describe =  ""

      
      var createtime = "2019-10-11 08"
      var disable_black = false
      var label = "中超,中国男足,广州恒大,足球"
      var match_id = "0"
      var model = "news"
      var pinglun = "2019_10_11-news-zuqiu-5d9fcd4685590"
      var tag = ""
      var thumbnail = "http"
      var title = "粤媒：艾克森存在感不强，他在国足面临与恒大相似的窘境　"
      var top_order = "0"
      var top_position = "2"
      var top_time = "0"
      var type = "zuqiu"
      var url = "/zuqiu/2019-10-11/5d9fcd4685590.htm"
      var version_url = "/zuqiu/2019-10-11/5d9fcd4685590_version2.htm"
    
    init(json:JSON) {
        self.createtime = json["createtime"].stringValue
        self.disable_black = json["disable_black"].boolValue
        self.label = json["label"].stringValue
        self.match_id = json["match_id"].stringValue
        self.model = json["model"].stringValue
        self.pinglun = json["pinglun"].stringValue
        self.tag = json["tag"].stringValue
        self.thumbnail = json["thumbnail"].stringValue
        self.title = json["title"].stringValue
        self.top_order = json["top_order"].stringValue
        self.top_position = json["top_position"].stringValue
        self.top_time = json["top_time"].stringValue
        self.type = json["type"].stringValue
        self.url = json["url"].stringValue
        self.version_url = json["version_url"].stringValue

    }
}


struct Comments {
    var root_num = 24;
    var root_normal_num = 24;
    var all_num = 46;
    var all_short_num = "46";
    var hot_num = 2 ;
    var time_interval = 360
    init(json:JSON) {
        root_num = json["root_num"].intValue
        root_normal_num = json["root_normal_num"].intValue
        all_num = json["all_num"].intValue
        all_short_num = json["all_short_num"].stringValue
        hot_num = json["hot_num"].intValue
        time_interval = json["time_interval"].intValue

    }
}




///评论数
//https://cache.zhibo8.cc/json/2019_10_11/news/zuqiu/5d9fd899ab085_count.json


/**
 资料.....
 {
 "status" : 1,
 "message" : "查询成功",
 "data" : {
 "honor" : {
 "list" : [
 {
 "picture" : "http:\/\/tu.duoduocdn.com\/avatar\/teamhonor\/3\/c9652952e64548202eb6b4d5d2e527d5.png",
 "season" : [
 "2019",
 "2018",
 "2017",
 "2015"
 ],
 "honor" : "世俱杯冠军 X4"
 },
 {
 "picture" : "http:\/\/tu.duoduocdn.com\/avatar\/teamhonor\/3\/23899f71ef88dd15654ef6f6427b6a37.png",
 "season" : [
 "2018",
 "2017",
 "2015",
 "2003"
 ],
 "honor" : "欧洲超级杯冠军 X4"
 },
 {
 "picture" : "http:\/\/tu.duoduocdn.com\/avatar\/teamhonor\/3\/cf6444257cb2ac3a638dac7bd0e3ad05.png",
 "season" : [
 "2017\/2018",
 "2016\/2017",
 "2015\/2016",
 "2013\/2014",
 "2001\/2002",
 "1999\/2000",
 "1997\/1998",
 "1965\/1966",
 "1959\/1960",
 "1958\/1959",
 "1957\/1958",
 "1956\/1957",
 "1955\/1956"
 ],
 "honor" : "欧冠冠军 X13"
 },
 {
 "picture" : "http:\/\/tu.duoduocdn.com\/avatar\/teamhonor\/3\/229dea165070f120d1d5717acb27d953.png",
 "season" : [
 "2018",
 "2013",
 "2009",
 "2004",
 "2002",
 "1998",
 "1994",
 "1991",
 "1990",
 "1989"
 ],
 "honor" : "西班牙超级杯冠军 X10"
 },
 {
 "picture" : "http:\/\/tu.duoduocdn.com\/avatar\/teamhonor\/3\/5698621dedc5f8fa16f5325ecd841ad7.png",
 "season" : [
 "2016\/2017",
 "2011\/2012",
 "2007\/2008",
 "2006\/2007",
 "2002\/2003",
 "2000\/2001",
 "1996\/1997",
 "1994\/1995",
 "1989\/1990",
 "1988\/1989",
 "1987\/1988",
 "1986\/1987",
 "1985\/1986",
 "1979\/1980",
 "1978\/1979",
 "1977\/1978",
 "1975\/1976",
 "1974\/1975",
 "1971\/1972",
 "1968\/1969",
 "1967\/1968",
 "1966\/1967",
 "1964\/1965",
 "1963\/1964",
 "1962\/1963",
 "1961\/1962",
 "1960\/1961",
 "1957\/1958",
 "1956\/1957",
 "1954\/1955",
 "1953\/1954",
 "1932\/1933",
 "1931\/1932"
 ],
 "honor" : "西甲冠军 X33"
 },
 {
 "picture" : "http:\/\/tu.duoduocdn.com\/avatar\/teamhonor\/3\/54587f78e2b670b8789dd53e7c233bac.png",
 "season" : [
 "2014",
 "2011",
 "1993",
 "1989",
 "1982",
 "1980",
 "1975",
 "1974",
 "1970",
 "1962",
 "1947",
 "1946",
 "1936",
 "1934",
 "1917",
 "1908",
 "1907",
 "1906",
 "1905"
 ],
 "honor" : "国王杯冠军 X19"
 },
 {
 "picture" : "http:\/\/tu.duoduocdn.com\/avatar\/teamhonor\/3\/9af2160bfb9bf6354e440114f542bdd1.png",
 "season" : [
 "2003",
 "1999",
 "1961"
 ],
 "honor" : "洲际杯冠军 X3"
 },
 {
 "picture" : "http:\/\/tu.duoduocdn.com\/avatar\/teamhonor\/3\/7eef06b54f69e3bbcf084c0dcacff75b.png",
 "season" : [
 "1986",
 "1985"
 ],
 "honor" : "欧洲联盟杯冠军 X2"
 },
 {
 "picture" : "http:\/\/tu.duoduocdn.com\/avatar\/teamhonor\/3\/default.png",
 "season" : [
 "1984\/1985"
 ],
 "honor" : "Spanish League Cup Winner X1"
 }
 ],
 "title" : "球队荣誉"
 },
 "intro" : {
 "title" : "球队简介",
 "data" : "皇家马德里足球俱乐部（RealMadridClubdeFútbol，中文简称为皇马）是一家位于西班牙首都马德里的足球俱乐部，球队成立于1902年3月6日，前称马德里足球队。1920年6月29日，时任西班牙国王阿方索十三世把\"Real\"（西语，皇家之意）一词加于俱乐部名前，徽章上加上了皇冠，以此来推动足球运动在西班牙首都马德里市的发展。从此，俱乐部正式更名为皇家马德里足球俱乐部。皇家马德里足球俱乐部，拥有众多世界球星。2000年12月11日被国际足球联合会（FIFA）评为20世纪最伟大的球队。2009年9月10日被国际足球历史和统计联合会评为20世纪欧洲最佳俱乐部。2014年9月10日被评为2014年度欧洲最佳俱乐部。皇家马德里已夺得过12次欧洲冠军杯冠军（夺冠次数欧洲足坛第一）、33次西班牙足球甲级联赛冠军（西甲第一）、19次西班牙国王杯冠军、10次西班牙超级杯冠军、4次欧洲超级杯冠军、5次世俱杯冠军（含前身丰田杯，夺冠次数第一）。2017年5月22日，皇马客场2-0完胜马拉加，夺得本赛季联赛冠军，这是皇马近5年来首个西甲冠军，俱乐部历史上第33次联赛捧杯！6月4日，皇家马德里4-1大胜尤文图斯，夺得本赛季欧洲冠军杯冠军，这是皇马近4年来第3个欧冠冠军，俱乐部历史上第12次欧冠冠军，也成为欧冠改制以来第一支成功卫冕欧冠冠军的球队。8月9日，2017年欧洲超级杯，皇马2-1击败曼联，史上第4次获欧超杯冠军。同年12月17日，蝉联世俱杯冠军。12月29日，获得2017年度GlobeSoccer年度最佳俱乐部奖。"
 },
 "transfers" : {
 "list" : [
 {
 "date" : "2020-06-30",
 "to_team_id" : "165",
 "player" : "豪尔赫-德弗鲁托斯",
 "to_team_logo" : "http:\/\/duihui.qiumibao.com\/zuqiu\/huangjiamadeli.png",
 "from_team_id" : "465",
 "from_team" : "巴拉多利德",
 "fee" : "回归",
 "type" : "转入",
 "to_team" : "皇家马德里",
 "player_id" : "58255",
 "fee_new" : "回归",
 "from_team_logo" : "http:\/\/duihui.qiumibao.com\/zuqiu\/baladuolide.png"
 },
 {
 "date" : "2020-06-30",
 "to_team_id" : "931",
 "player" : "阿雷奥拉",
 "to_team_logo" : "http:\/\/duihui.qiumibao.com\/zuqiu\/balishengrierman.png",
 "from_team_id" : "165",
 "from_team" : "皇家马德里",
 "fee" : "回归",
 "type" : "转出",
 "to_team" : "巴黎圣日耳曼",
 "player_id" : "9944",
 "fee_new" : "回归",
 "from_team_logo" : "http:\/\/duihui.qiumibao.com\/zuqiu\/huangjiamadeli.png"
 },
 {
 "date" : "2019-09-02",
 "to_team_id" : "165",
 "player" : "阿雷奥拉",
 "to_team_logo" : "http:\/\/duihui.qiumibao.com\/zuqiu\/huangjiamadeli.png",
 "from_team_id" : "931",
 "from_team" : "巴黎圣日耳曼",
 "fee" : "出租\n200万",
 "type" : "转入",
 "to_team" : "皇家马德里",
 "player_id" : "9944",
 "fee_new" : "出租200万",
 "from_team_logo" : "http:\/\/duihui.qiumibao.com\/zuqiu\/balishengrierman.png"
 }
 ],
 "title" : "转会信息",
 "show_more" : {
 "mode" : "web",
 "title" : "查看更多",
 "url" : "https:\/\/db.qiumibao.com\/f\/zuqiu\/team\/transfers?id=165&showfeedback=1"
 }
 },
 "info" : [
 {
 "key" : "全称：",
 "value" : "皇家马德里"
 },
 {
 "key" : "成立：",
 "value" : "1902"
 },
 {
 "key" : "所在城市：",
 "value" : "马德里"
 },
 {
 "key" : "官网：",
 "value" : "http:\/\/www.realmadrid.com"
 }
 ]
 }
 }
 
 
 c阵容
 {
   "status" : 1,
   "message" : "查询成功",
   "data" : {
     "coaching_staff" : {
       "list" : [
         {
           "name" : "纳格尔斯曼",
           "id" : "100",
           "position" : "主教练",
           "redirect" : {
             "url" : "https:\/\/data.zhibo8.cc\/html\/mobile\/coach.html?id=100",
             "mode" : "web"
           },
           "avatar" : "http:\/\/tu.duoduocdn.com\/avatar\/trainer\/3\/0\/100.jpg"
         }
       ],
       "show_more" : {
         "title" : "查看更多",
         "mode" : "web",
         "url" : "https:\/\/db.qiumibao.com\/f\/zuqiu\/team\/staff?id=661&showfeedback=1"
       },
       "title" : "教练组"
     },
     "squad" : [
       {
         "list" : [
           {
             "transfer" : {
               "id" : "143",
               "name" : "埃弗顿",
               "logo" : "http:\/\/duihui.qiumibao.com\/zuqiu\/aifudun.png"
             },
             "id" : "2104",
             "avatar" : "http:\/\/tu.duoduocdn.com\/avatar\/players\/3\/2\/36802.jpg",
             "number" : "17",
             "injury" : null,
             "assist" : "0",
             "name" : "卢克曼",
             "u23" : "0",
             "goal" : "0",
             "captain" : "0",
             "position" : "前锋"
           },
           {
             "transfer" : null,
             "id" : "3446",
             "avatar" : "http:\/\/tu.duoduocdn.com\/avatar\/players\/3\/61\/38061.jpg",
             "number" : "7",
             "injury" : null,
             "assist" : "4",
             "name" : "萨比策",
             "u23" : "0",
             "goal" : "4",
             "captain" : "0",
             "position" : "前锋"
           },
           {
             "transfer" : {
               "id" : "569",
               "name" : "罗马",
               "logo" : "http:\/\/duihui.qiumibao.com\/zuqiu\/luoma.png"
             },
             "id" : "7838",
             "avatar" : "http:\/\/tu.duoduocdn.com\/avatar\/players\/3\/45\/37245.jpg",
             "number" : "21",
             "injury" : null,
             "assist" : "0",
             "name" : "希克",
             "u23" : "0",
             "goal" : "0",
             "captain" : "0",
             "position" : "前锋"
           },
           {
             "transfer" : null,
             "id" : "8820",
             "avatar" : "http:\/\/tu.duoduocdn.com\/avatar\/players\/3\/62\/38062.jpg",
             "number" : "11",
             "injury" : null,
             "assist" : "1",
             "name" : "维尔纳",
             "u23" : "0",
             "goal" : "7",
             "captain" : "0",
             "position" : "前锋"
           },
           {
             "transfer" : null,
             "id" : "8821",
             "avatar" : "http:\/\/tu.duoduocdn.com\/avatar\/players\/3\/59\/38059.jpg",
             "number" : "10",
             "injury" : null,
             "assist" : "2",
             "name" : "福斯贝里",
             "u23" : "0",
             "goal" : "2",
             "captain" : "0",
             "position" : "前锋"
           },
           {
             "transfer" : null,
             "id" : "8822",
             "avatar" : "http:\/\/tu.duoduocdn.com\/avatar\/players\/3\/64\/38064.jpg",
             "number" : "9",
             "injury" : null,
             "assist" : "6",
             "name" : "鲍尔森",
             "u23" : "0",
             "goal" : "1",
             "captain" : "0",
             "position" : "前锋"
           },
           {
             "transfer" : null,
             "id" : "54573",
             "avatar" : "http:\/\/tu.duoduocdn.com\/avatar\/players\/3\/50\/104550.jpg",
             "number" : "20",
             "injury" : null,
             "assist" : "0",
             "name" : "库尼亚",
             "u23" : "0",
             "goal" : "0",
             "captain" : "0",
             "position" : "前锋"
           },
           {
             "transfer" : null,
             "id" : "88825",
             "avatar" : "http:\/\/tu.duoduocdn.com\/avatar\/players\/3\/82\/236882.jpg",
             "number" : "35",
             "injury" : null,
             "assist" : "0",
             "name" : "Fabrice Hartmann",
             "u23" : "0",
             "goal" : "0",
             "captain" : "0",
             "position" : "前锋"
           },
           {
             "transfer" : null,
             "id" : "89016",
             "avatar" : "http:\/\/tu.qiumibao.com\/avatar\/default-avatar.png",
             "number" : "-",
             "injury" : null,
             "assist" : "0",
             "name" : "Jacob Ruhner",
             "u23" : "0",
             "goal" : "0",
             "captain" : "0",
             "position" : "前锋"
           },
           {
             "transfer" : null,
             "id" : "89050",
             "avatar" : "http:\/\/tu.duoduocdn.com\/avatar\/players\/3\/44\/381444.jpg",
             "number" : "11",
             "injury" : null,
             "assist" : "0",
             "name" : "Oliver Bias",
             "u23" : "0",
             "goal" : "0",
             "captain" : "0",
             "position" : "前锋"
           }
         ],
         "title" : "前锋"
       },
       {
         "title" : "中场",
         "list" : [
           {
             "name" : "伊尔桑克",
             "transfer" : null,
             "avatar" : "http:\/\/tu.duoduocdn.com\/avatar\/players\/3\/54\/38054.jpg",
             "id" : "3445",
             "number" : "13",
             "assist" : "0",
             "injury" : null,
             "captain" : "0",
             "position" : "中场",
             "u23" : "0",
             "goal" : "0"
           },
           {
             "name" : "德姆",
             "transfer" : null,
             "avatar" : "http:\/\/tu.duoduocdn.com\/avatar\/players\/3\/53\/38053.jpg",
             "id" : "8828",
             "number" : "31",
             "assist" : "0",
             "injury" : null,
             "captain" : "0",
             "position" : "中场",
             "u23" : "0",
             "goal" : "0"
           },
           {
             "name" : "坎普尔",
             "transfer" : null,
             "avatar" : "http:\/\/tu.duoduocdn.com\/avatar\/players\/3\/56\/38056.jpg",
             "id" : "8829",
             "number" : "44",
             "assist" : "0",
             "injury" : {
               "content" : "脚踝问题，预计复出时间未知",
               "id" : "111774"
             },
             "captain" : "0",
             "position" : "中场",
             "u23" : "0",
             "goal" : "0"
           },
           {
             "name" : "莱默",
             "transfer" : null,
             "avatar" : "http:\/\/tu.duoduocdn.com\/avatar\/players\/3\/57\/38057.jpg",
             "id" : "8830",
             "number" : "27",
             "assist" : "0",
             "injury" : null,
             "captain" : "0",
             "position" : "中场",
             "u23" : "0",
             "goal" : "0"
           },
           {
             "name" : "沃尔夫",
             "transfer" : {
               "id" : "768",
               "logo" : "http:\/\/duihui.qiumibao.com\/zuqiu\/saercibao.png",
               "name" : "萨尔茨堡"
             },
             "avatar" : "http:\/\/tu.duoduocdn.com\/avatar\/players\/3\/97\/62297.jpg",
             "id" : "9296",
             "number" : "19",
             "assist" : "0",
             "injury" : {
               "content" : "骨折，预计复出时间未知",
               "id" : "107210"
             },
             "captain" : "0",
             "position" : "中场",
             "u23" : "0",
             "goal" : "0"
           },
           {
             "name" : "恩昆库",
             "transfer" : {
               "id" : "931",
               "logo" : "http:\/\/duihui.qiumibao.com\/zuqiu\/balishengrierman.png",
               "name" : "巴黎圣日耳曼"
             },
             "avatar" : "http:\/\/tu.duoduocdn.com\/avatar\/players\/3\/92\/37492.jpg",
             "id" : "9937",
             "number" : "18",
             "assist" : "2",
             "injury" : null,
             "captain" : "0",
             "position" : "中场",
             "u23" : "0",
             "goal" : "1"
           },
           {
             "name" : "海达拉",
             "transfer" : null,
             "avatar" : "http:\/\/tu.duoduocdn.com\/avatar\/players\/3\/69\/54869.jpg",
             "id" : "42106",
             "number" : "8",
             "assist" : "1",
             "injury" : null,
             "captain" : "0",
             "position" : "中场",
             "u23" : "0",
             "goal" : "0"
           },
           {
             "name" : "亚当斯",
             "transfer" : null,
             "avatar" : "http:\/\/tu.duoduocdn.com\/avatar\/players\/3\/59\/55359.jpg",
             "id" : "42455",
             "number" : "14",
             "assist" : "0",
             "injury" : {
               "content" : "，预计复出时间为2019年09月30号",
               "id" : "112546"
             },
             "captain" : "0",
             "position" : "中场",
             "u23" : "0",
             "goal" : "0"
           },
           {
             "name" : "Tom Krauß",
             "transfer" : null,
             "avatar" : "http:\/\/tu.qiumibao.com\/avatar\/default-avatar.png",
             "id" : "88978",
             "number" : "53",
             "assist" : "0",
             "injury" : null,
             "captain" : "0",
             "position" : "中场",
             "u23" : "0",
             "goal" : "0"
           },
           {
             "name" : "Mads Bidstrup",
             "transfer" : null,
             "avatar" : "http:\/\/tu.duoduocdn.com\/avatar\/players\/3\/41\/381441.jpg",
             "id" : "89000",
             "number" : "49",
             "assist" : "0",
             "injury" : null,
             "captain" : "0",
             "position" : "中场",
             "u23" : "0",
             "goal" : "0"
           },
           {
             "name" : "Max Winter",
             "transfer" : null,
             "avatar" : "http:\/\/tu.duoduocdn.com\/avatar\/players\/3\/39\/381439.jpg",
             "id" : "89049",
             "number" : "8",
             "assist" : "0",
             "injury" : null,
             "captain" : "0",
             "position" : "中场",
             "u23" : "0",
             "goal" : "0"
           }
         ]
       },
       {
         "title" : "后卫",
         "list" : [
           {
             "assist" : "0",
             "u23" : "0",
             "captain" : "0",
             "avatar" : "http:\/\/tu.duoduocdn.com\/avatar\/players\/3\/40\/37840.jpg",
             "number" : "22",
             "position" : "后卫",
             "name" : "穆杰莱",
             "goal" : "0",
             "transfer" : null,
             "id" : "4355",
             "injury" : null
           },
           {
             "assist" : "1",
             "u23" : "0",
             "captain" : "0",
             "avatar" : "http:\/\/tu.duoduocdn.com\/avatar\/players\/3\/49\/38049.jpg",
             "number" : "23",
             "position" : "后卫",
             "name" : "哈尔斯滕伯格",
             "goal" : "1",
             "transfer" : null,
             "id" : "8832",
             "injury" : null
           },
           {
             "assist" : "0",
             "u23" : "0",
             "captain" : "0",
             "avatar" : "http:\/\/tu.duoduocdn.com\/avatar\/players\/3\/51\/38051.jpg",
             "number" : "16",
             "position" : "后卫",
             "name" : "科洛斯特曼",
             "goal" : "1",
             "transfer" : null,
             "id" : "8833",
             "injury" : null
           },
           {
             "assist" : "0",
             "u23" : "0",
             "captain" : "0",
             "avatar" : "http:\/\/tu.duoduocdn.com\/avatar\/players\/3\/45\/38045.jpg",
             "number" : "5",
             "position" : "后卫",
             "name" : "乌帕梅卡诺",
             "goal" : "0",
             "transfer" : null,
             "id" : "8836",
             "injury" : null
           },
           {
             "assist" : "0",
             "u23" : "0",
             "captain" : "0",
             "avatar" : "http:\/\/tu.duoduocdn.com\/avatar\/players\/3\/46\/38046.jpg",
             "number" : "4",
             "position" : "后卫",
             "name" : "奥尔班",
             "goal" : "1",
             "transfer" : null,
             "id" : "8837",
             "injury" : null
           },
           {
             "assist" : "0",
             "u23" : "0",
             "captain" : "0",
             "avatar" : "http:\/\/tu.duoduocdn.com\/avatar\/players\/3\/48\/38048.jpg",
             "number" : "6",
             "position" : "后卫",
             "name" : "科纳特",
             "goal" : "0",
             "transfer" : null,
             "id" : "8839",
             "injury" : null
           },
           {
             "assist" : "0",
             "u23" : "0",
             "captain" : "0",
             "avatar" : "http:\/\/tu.duoduocdn.com\/avatar\/players\/3\/50\/57350.jpg",
             "number" : "26",
             "position" : "后卫",
             "name" : "阿姆帕杜",
             "goal" : "0",
             "transfer" : {
               "id" : "138",
               "logo" : "http:\/\/duihui.qiumibao.com\/zuqiu\/qieerxi.png",
               "name" : "切尔西"
             },
             "id" : "43897",
             "injury" : null
           },
           {
             "assist" : "0",
             "u23" : "0",
             "captain" : "0",
             "avatar" : "http:\/\/tu.duoduocdn.com\/avatar\/players\/3\/25\/67225.jpg",
             "number" : "3",
             "position" : "后卫",
             "name" : "萨拉基奥",
             "goal" : "1",
             "transfer" : null,
             "id" : "54571",
             "injury" : null
           },
           {
             "assist" : "0",
             "u23" : "0",
             "captain" : "0",
             "avatar" : "http:\/\/tu.duoduocdn.com\/avatar\/players\/3\/90\/265790.jpg",
             "number" : "36",
             "position" : "后卫",
             "name" : "Luan C?ndido",
             "goal" : "0",
             "transfer" : null,
             "id" : "56932",
             "injury" : null
           },
           {
             "assist" : "0",
             "u23" : "0",
             "captain" : "0",
             "avatar" : "http:\/\/tu.qiumibao.com\/avatar\/default-avatar.png",
             "number" : "37",
             "position" : "后卫",
             "name" : "Frederik Jäkel",
             "goal" : "0",
             "transfer" : null,
             "id" : "88545",
             "injury" : null
           },
           {
             "assist" : "0",
             "u23" : "0",
             "captain" : "0",
             "avatar" : "http:\/\/tu.qiumibao.com\/avatar\/default-avatar.png",
             "number" : "-",
             "position" : "后卫",
             "name" : "Malik Talabidi",
             "goal" : "0",
             "transfer" : null,
             "id" : "89003",
             "injury" : null
           },
           {
             "assist" : "0",
             "u23" : "0",
             "captain" : "0",
             "avatar" : "http:\/\/tu.qiumibao.com\/avatar\/default-avatar.png",
             "number" : "-",
             "position" : "后卫",
             "name" : "Anton Rücker",
             "goal" : "0",
             "transfer" : null,
             "id" : "89015",
             "injury" : null
           }
         ]
       },
       {
         "title" : "守门员",
         "list" : [
           {
             "assist" : "-",
             "u23" : "0",
             "captain" : "0",
             "avatar" : "http:\/\/tu.duoduocdn.com\/avatar\/players\/3\/41\/38041.jpg",
             "number" : "1",
             "position" : "守门员",
             "name" : "古拉茨",
             "goal" : "0",
             "transfer" : null,
             "id" : "8842",
             "injury" : null
           },
           {
             "assist" : "-",
             "u23" : "0",
             "captain" : "0",
             "avatar" : "http:\/\/tu.duoduocdn.com\/avatar\/players\/3\/42\/38042.jpg",
             "number" : "28",
             "position" : "守门员",
             "name" : "姆沃戈",
             "goal" : "0",
             "transfer" : null,
             "id" : "8843",
             "injury" : null
           },
           {
             "assist" : "-",
             "u23" : "0",
             "captain" : "0",
             "avatar" : "http:\/\/tu.duoduocdn.com\/avatar\/players\/3\/82\/38482.jpg",
             "number" : "33",
             "position" : "守门员",
             "name" : "绍纳",
             "goal" : "0",
             "transfer" : {
               "name" : "汉诺威",
               "logo" : "http:\/\/duihui.qiumibao.com\/zuqiu\/hannuowei.png",
               "id" : "666"
             },
             "id" : "9035",
             "injury" : null
           }
         ]
       }
     ]
   }
 }
 
 
 新闻
 {
   "status" : "success",
   "data" : {
     "prev_date" : "",
     "list" : [
       {
         "disable_black" : false,
         "label" : "西甲,皇家马德里,皇家社会,足球",
         "top_time" : "0",
         "url" : "\/zuqiu\/2019-09-30\/5d915176901a6.htm",
         "title" : "厄德高本赛季创造23次机会西甲居首，已奉献2球2助",
         "version_url" : "\/zuqiu\/2019-09-30\/5d915176901a6_version4.htm",
         "createtime" : "2019-09-30 08:51:02",
         "top_position" : "2",
         "type" : "zuqiu",
         "top_order" : "0",
         "tag" : "",
         "match_id" : "0",
         "pinglun" : "2019_09_30-news-zuqiu-5d915176901a6",
         "thumbnail" : "http:\/\/tu.duoduocdn.com\/uploads\/day_190930\/201909300849188061_thumb.jpg",
         "model" : "news"
       },
       {
         "disable_black" : false,
         "label" : "足球,西甲,皇家马德里,巴塞罗那,瓦伦西亚,马德里竞技,毕尔巴鄂,皇家社会,比利亚雷亚尔,塞维利亚,西班牙人,塞尔塔,埃瓦尔,贝蒂斯,阿拉维斯,莱加内斯,莱万特,赫塔费,巴拉多利德,奥萨苏纳,格拉纳达,马洛卡",
         "top_time" : "0",
         "url" : "\/zuqiu\/2019-09-30\/5d91504bcfa6e.htm",
         "title" : "西甲第7轮综述：马德里德比互交白卷  巴萨客胜赫塔菲",
         "version_url" : "\/zuqiu\/2019-09-30\/5d91504bcfa6e_version2.htm",
         "createtime" : "2019-09-30 08:46:03",
         "top_position" : "0",
         "type" : "zuqiu",
         "top_order" : null,
         "tag" : "",
         "match_id" : "0",
         "pinglun" : "2019_09_30-news-zuqiu-5d91504bcfa6e",
         "thumbnail" : "http:\/\/tu.duoduocdn.com\/uploads\/news\/day_190930\/201909300808486944.jpg",
         "model" : "news"
       },
       {
         "disable_black" : false,
         "label" : "西甲,皇家马德里,巴塞罗那,德甲,拜仁慕尼黑,足球",
         "top_time" : "0",
         "url" : "\/zuqiu\/2019-09-30\/5d914de88b0be.htm",
         "title" : "当选全场最佳，维尼修斯评论库蒂尼奥ins：最好的库鸟",
         "version_url" : "\/zuqiu\/2019-09-30\/5d914de88b0be_version2.htm",
         "createtime" : "2019-09-30 08:35:52",
         "top_position" : "2",
         "type" : "zuqiu",
         "top_order" : "0",
         "tag" : "",
         "match_id" : "0",
         "pinglun" : "2019_09_30-news-zuqiu-5d914de88b0be",
         "thumbnail" : "http:\/\/tu.duoduocdn.com\/uploads\/day_190930\/5d914cd56fae5_thumb.jpg",
         "model" : "news"
       },
       {
         "disable_black" : false,
         "label" : "西甲,皇家马德里,马德里竞技,足球",
         "top_time" : "0",
         "url" : "\/zuqiu\/2019-09-30\/5d914bfd60211.htm",
         "title" : "记者：马竞不会因疑似辱骂裁判起诉拉莫斯",
         "version_url" : "\/zuqiu\/2019-09-30\/5d914bfd60211_version3.htm",
         "createtime" : "2019-09-30 08:27:41",
         "top_position" : "2",
         "type" : "zuqiu",
         "top_order" : "0",
         "tag" : "",
         "match_id" : "0",
         "pinglun" : "2019_09_30-news-zuqiu-5d914bfd60211",
         "thumbnail" : "http:\/\/tu.duoduocdn.com\/uploads\/day_181106\/5be07d1815aee_thumb.jpg",
         "model" : "news"
       },
       {
         "disable_black" : false,
         "label" : "英超,利物浦,西甲,皇家马德里,意甲,国际米兰,德甲,拜仁慕尼黑,法甲,巴黎圣日耳曼,足球",
         "top_time" : "0",
         "url" : "\/zuqiu\/2019-09-30\/5d914bb2b80dc.htm",
         "title" : "五大联赛榜首与第十分差：英超遥遥领先，西甲仅差6分",
         "version_url" : "\/zuqiu\/2019-09-30\/5d914bb2b80dc_version3.htm",
         "createtime" : "2019-09-30 08:26:26",
         "top_position" : "2",
         "type" : "zuqiu",
         "top_order" : "0",
         "tag" : "",
         "match_id" : "0",
         "pinglun" : "2019_09_30-news-zuqiu-5d914bb2b80dc",
         "thumbnail" : "http:\/\/tu.duoduocdn.com\/uploads\/day_190827\/5d644979be30f_thumb.jpg",
         "model" : "news"
       },
       {
         "disable_black" : false,
         "label" : "西甲,皇家马德里,马德里竞技,足球",
         "top_time" : "0",
         "url" : "\/zuqiu\/2019-09-30\/5d914691a45ee.htm",
         "title" : "拉莫斯疑似出言不逊，科斯塔找裁判理论：上季我被禁8场呢",
         "version_url" : "\/zuqiu\/2019-09-30\/5d914691a45ee_version3.htm",
         "createtime" : "2019-09-30 08:04:33",
         "top_position" : "2",
         "type" : "zuqiu",
         "top_order" : "0",
         "tag" : "",
         "match_id" : "0",
         "pinglun" : "2019_09_30-news-zuqiu-5d914691a45ee",
         "thumbnail" : "http:\/\/wx3.sinaimg.cn\/small\/006oGTSVgy1g7h7sv7ynlg3087049e82.gif",
         "model" : "news"
       },
       {
         "disable_black" : false,
         "label" : "英超,曼联,西甲,皇家马德里,意甲,AC米兰,国际米兰,罗马,佛罗伦萨,德甲,拜仁慕尼黑,多特蒙德,勒沃库森,沙尔克,门兴,沃尔夫斯堡,法兰克福,莱比锡红牛,意大利,足球",
         "top_time" : "0",
         "url" : "\/zuqiu\/2019-09-30\/5d90f2b0057f1.htm",
         "title" : "早报：米兰3连败仅高降级区1分，前6轮4负近81年首次",
         "version_url" : "\/zuqiu\/2019-09-30\/5d90f2b0057f1_version10.htm",
         "createtime" : "2019-09-30 06:44:10",
         "top_position" : "0",
         "type" : "zuqiu",
         "top_order" : null,
         "tag" : "",
         "match_id" : "0",
         "pinglun" : "2019_09_30-news-zuqiu-5d90f2b0057f1",
         "thumbnail" : "http:\/\/tu.duoduocdn.com\/uploads\/news\/day_190930\/201909300444408453_thumb.jpg",
         "model" : "news"
       }
     ]
   }
 }
 
 */

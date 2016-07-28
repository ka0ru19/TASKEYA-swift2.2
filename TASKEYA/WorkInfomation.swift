//
//  WorkInfomation.swift
//  TASKEYA
//
//  Created by 井上航 on 2016/07/19.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct Work {
    
    var w_updatedAt: NSDate!
    var w_R_Deadline: NSDate?
    var w_Is_Done: Bool!
    var w_RequesterName: String!
    var w_NewInfo: Bool!
    var w_createdAt: NSDate!
    var w_Other: String?
    var w_Price: Int!
    var w_C_Deadline: NSDate!
    var w_Title: String!
    var w_Requester_ID: String!
    var w_Work_ID: String!
    var w_Category1: String!
    var w_Opponents: String?
    var w_ProfileURL: UIImage?
    var w_Category2: String?
    var w_Status: String?
    var w_Detail: String!
    var w_Location: String?
    
    
//    init() {
//        print("何もせずWorkを初期化->nilやばいよ")
//    }
    
    init(workId: String) {
        // workIDからAPIを叩いてWorkを取得
        let request = "https://taskeya.com/mobile/?code=kiyocixo113aks331mxhr76567ejxaaa&func=getjobdata&wid=" + workId
        
        // 同期処理
//        let semaphore = dispatch_semaphore_create(0)
        
        Alamofire.request(.GET, request).responseJSON
            {response in
                
                guard let object = response.result.value else {
                    return
                }
                let json = JSON(object)
                print(json[0][0])
                
//                dispatch_semaphore_signal(semaphore)
                self.set(json[0][0])
                
        }
        
        //Wait for the request to complete
//        while dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW) != 0 {
//            NSRunLoop.currentRunLoop().runMode(NSDefaultRunLoopMode, beforeDate: NSDate(timeIntervalSinceNow: 10))
//        }

    }
    
    init(json: JSON) {
        set(json)
    }
    
    mutating func set(json: JSON) {
        print("mutating func set(json: JSON)")
        print(json)
        print(json["updatedAt"].string!)
        // jsonからローカルで変換
        
        w_updatedAt = strToNSDate(json["updatedAt"].string!)
        w_R_Deadline = strToNSDate(json["R_Deadline"].string!)
        w_Is_Done = strToBool(json["Is_Done"].string!)
        w_RequesterName = json["RequesterName"].string!
        w_NewInfo = strToBool(json["NewInfo"].string!)
        w_createdAt = strToNSDate(json["createdAt"].string!)
        w_Other = json["Other"].string!
        w_Price = Int(json["Price"].string!)
        w_C_Deadline = strToNSDate(json["C_Deadline"].string!)
        w_Title = json["Title"].string!
        w_Requester_ID = json["Requester_ID"].string!
        w_Work_ID = json["Work_ID"].string!
        w_Category1 = json["Category1"].string!
        w_Opponents = json["Opponents"].string!
        
        //        print(json["w_ProfileURL"].string)
        w_ProfileURL = strToUIImage(json["ProfileURL"].string!) //strToUIImage(json["w_ProfileURL"].string!)
        //UIImage(data: NSData(contentsOfURL: NSURL(fileURLWithPath: "http://i.gzn.jp/img/2016/03/22/apple-special-event/00_m.jpg"))!)
        
        //https:\\/\\/taskeya.com\\/assets\\/profile\\/3804b198117a1347dd4d6aa9c86ec38816644dec.jpg
        
        //strToUIImage("https:\\/\\/taskeya.com\\/assets\\/profile\\/3804b198117a1347dd4d6aa9c86ec38816644dec.jpg")
        
        w_Category2 = json["Category2"].string!
        w_Status = json["Status"].string!
        w_Detail = json["Detail"].string!
        w_Location = json["Location"].string!
    }
    
    
    func strToNSDate(str: String?) -> NSDate? {
        let date_formatter: NSDateFormatter = NSDateFormatter()
        date_formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return date_formatter.dateFromString(str!)
    }
    
    func strToBool(str: String) -> Bool? {
        if str == "TRUE" {
            return true
        } else if str == "FALSE" {
            return false
        } else {
            print("error: Booooooooool???")
            return nil
        }
    }
    
    // 認証が必要なため写真表示不可
    func strToUIImage(str: String) -> UIImage? {
        print(str)
        let urlStr = str.stringByReplacingOccurrencesOfString("https://", withString: "https://kiyo:kiyokiyo@")
        print(urlStr)
        //        return UIImage(data: NSData(contentsOfURL: NSURL(fileURLWithPath: urlStr))!)!
        
        let url = NSURL(string: urlStr)
        
        do {
            let imgData = try NSData(contentsOfURL:url!,options: NSDataReadingOptions.DataReadingMappedIfSafe)
            return UIImage(data:imgData)
        } catch {
            print("Error: can't create image.")
        }
        
        
        
        //        let url = NSURL(string: img_url);
        //        let imgData: NSData
        //
        //        do {
        //            imgData = try NSData(contentsOfURL:url!,options: NSDataReadingOptions.DataReadingMappedIfSafe)
        //            let img = UIImage(data:imgData);
        //            let imgView = UIImageView(image:img);
        //            imgView.frame = CGRectMake(0, 0, 100, 50);
        //            self.view.addSubview(imgView);
        //        } catch {
        //            print("Error: can't create image.")
        //        }        
        return nil
    }
    
}

struct TableWork {
    
}


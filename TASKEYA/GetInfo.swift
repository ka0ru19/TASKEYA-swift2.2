//
//  GetInfo.swift
//  TASKEYA
//
//  Created by 井上航 on 2016/07/19.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

// 未完成
//func getWork(workId: String) -> Work {
//    let work = Work()
//    return work
//}

// 仕事を30件取得 -> 6件
func getWorkList(id: String) {
    
    var isYet: Bool = true
    
    print("仕事を30件取得開始")
    
    //        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    //        var id = appDelegate.app_TSK_ID
    //
    //        //        let requestUrl = "http://api.taskeya.com/mobile?uid='" + id! + "'&am='30'"
    //
    //        //        "TSK_ID" : "3804b198117a1347dd4d6aa9c86ec38816644dec"
    //
    let count = 6
    //
    //        id = "3804b198117a1347dd4d6aa9c86ec38816644dec"
    
    let requestUrl = "https://kiyo:kiyokiyo@taskeya.com/mobile/?code=kiyocixo113aks331mxhr76567ejxaaa&func=getjobs&uid=" + id + "&srt=createdAt&cnt=" + String(count)
    
    
    

    var workArray :[Work?] = []
    
    
        Alamofire.request(.GET, requestUrl).responseJSON
            {response in
                
                guard let object = response.result.value else {
                    return
                }
                let json = JSON(object)
                
                for i in 0 ..< json.count {
                    if i == 0 {
                        workArray.append(Work(json: json[0][0]))
                    } else {
                        workArray.append(Work(json: json[i][String(i)]))
                    }
                }
                
                print("1")
                isYet = false
                print(workArray)
                
                print("取得完了")
        }
    
    
}

    
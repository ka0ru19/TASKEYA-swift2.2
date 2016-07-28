//
//  NeedsBoardViewController.swift
//  TASKEYA
//
//  Created by 井上航 on 2016/05/05.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NeedsBoardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var table: UITableView!
    
    var userImage: UIImage?
    var selectedPost: Post?
    
    var postArray: [Post] = []
    var works: [[String: String?]] = []
    
    
    var workArray :[Work?] = []
    
    // 写真の読み込み
    let imgArray: [String] = [
        "c01.png",
        "c02.png",
        "c03.png",
        "c04.png",
        "c05.png",
        "c06.png",
        "c07.png"
    ]
    
    //
    let label2Array: [String] = [
        "2013/8/23 16:04",
        "2013/8/23 16:15",
        "2013/8/23 16:47",
        "2013/8/23 17:10",
        "2013/8/23 17:15",
        "2013/8/23 17:21",
        "2013/8/23 17:33"
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        
        //        tableView.estimatedRowHeight = 50.0
        //        table.estimatedRowHeight = 90.0
        //        table.rowHeight = UITableViewAutomaticDimension
        table.dataSource = self
        table.delegate = self
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        print("viewDidAppear")
        
//        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//        var id = appDelegate.app_TSK_ID
        
        
        
//        print(id)
        
        
        print("仕事を30件取得開始")
        
        //        let requestUrl = "http://api.taskeya.com/mobile?uid='" + id! + "'&am='30'"
        
        //        "TSK_ID" : "3804b198117a1347dd4d6aa9c86ec38816644dec"
        
        //        let count = 6
        
        
        // 「ud」というインスタンスをつくる。
        let ud = NSUserDefaults.standardUserDefaults()
        // キーがidの値をとります。
        var id = ud.objectForKey("tsk_id") as! String
        
//        id = "3804b198117a1347dd4d6aa9c86ec38816644dec"
        
        getWorkList(id)
        
        //        for item in array {
        //            print(item!.w_Title)
        //            print(item!.w_RequesterName)
        //            print(item!.w_createdAt)
        //        }
        
        //        if id != nil {
        //            getUserData()
        //        } else {
        //            print("error: no id.")
        //            table.reloadData()
        //        }
        
        
        
    }
    
    
    func inputArray(array: [Work?]) {
        postArray = []
        
        for work in workArray{
            let post = Post(workID: work!.w_Work_ID,
                userName: work!.w_RequesterName,
                userImage: work!.w_ProfileURL!,
                titleString: work!.w_Title,
                lastTime: work!.w_createdAt
            )
            postArray.append(post)
        }
        
        print("postArray")
        print(postArray)
        table.reloadData()
    }
    
    //Table Viewのセルの数を指定
    func tableView(table: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(workArray.count)
        return workArray.count
    }
    
    
    //各セルの要素を設定する
    func tableView(table: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // tableCell の ID で UITableViewCell のインスタンスを生成
        let cell = table.dequeueReusableCellWithIdentifier("tableCell", forIndexPath: indexPath)
        
        // Tag番号 1 で UIImageView インスタンスの生成
        let imageView = table.viewWithTag(1) as! UIImageView
        imageView.image = postArray[indexPath.row].userImage
        
        // Tag番号 ２ で UILabel インスタンスの生成
        let label1 = table.viewWithTag(2) as! UILabel
        label1.text = postArray[indexPath.row].userName as String
        //        let color = ColorManager() //インスタンス化
        //        label1.backgroundColor = color.mainColor()
        
        // Tag番号 ３ で UILabel インスタンスの生成
        let label2 = table.viewWithTag(3) as! UILabel
        label2.text = postArray[indexPath.row].titleString
        
        // Tag番号 4 で UILabel インスタンスの生成
        let label4 = table.viewWithTag(4) as! UILabel
        label4.text = String(postArray[indexPath.row].lastTime)
        
        return cell
    }
    
    // Cell が選択された場合
    func tableView(table: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath) {
        
        selectedPost = postArray[indexPath.row]
        if selectedPost != nil {
            // SubViewController へ遷移するために Segue を呼び出す
            performSegueWithIdentifier("toFriendsNeedVC",sender: nil)
        }
        
    }
    // 仕事を30件取得 -> 6件
    func getWorkList(id: String) {
        
        //        var isYet: Bool = true
        
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
        
        //        let requestUrl = "https://kiyo:kiyokiyo@taskeya.com/mobile/?code=kiyocixo113aks331mxhr76567ejxaaa&func=getjobs&uid=" + id + "&srt=createdAt&cnt=" + String(count)
        
        let requestUrl = "https://kiyo:kiyokiyo@taskeya.com/mobile/?code=kiyocixo113aks331mxhr76567ejxaaa&func=getjobs&uid="
            + id + "&srt=createdAt&cnt=" + String(6) // + "&sp=" + String("既に読み込んだ数: Int")
        
        
        Alamofire.request(.GET, requestUrl).responseJSON
            {response in
                
                guard let object = response.result.value else {
                    return
                }
                let json = JSON(object)
                print(json)
                
                self.workArray = []
                for i in 0 ..< json.count {
                    if i == 0 {
                        self.workArray.append(Work(json: json[0][0]))
                    } else {
                        self.workArray.append(Work(json: json[i][String(i)]))
                    }
                    
                    print(self.workArray.last)
                }
                
                print("1")
                //                isYet = false
                print(self.workArray)
                
                print("取得完了")
                
                
                
                self.inputArray(self.workArray)
        }
        
        
    }
    
    
    // Segue 準備
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "toFriendsNeedVC" {
            let nextVC: FriendsNeedViewController = (segue.destinationViewController as? FriendsNeedViewController)!
            // SubViewController のselectedImgに選択された画像を設定する
            //            nextVC.userImage = userImage
            nextVC.post = selectedPost
        }
    }
    
}

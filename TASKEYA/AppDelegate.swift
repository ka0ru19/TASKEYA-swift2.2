//
//  AppDelegate.swift
//  TASKEYA
//
//  Created by 井上航 on 2016/05/05.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    //    はじめての起動時に毎回呼び出される
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // 通知の許可を促す
        if (UIDevice.currentDevice().systemVersion as NSString).floatValue >= 8.0 {
            // iOS8以上
            let mySettings = UIUserNotificationSettings(forTypes: [.Badge, .Sound, .Alert,], categories: nil)
            
            application.registerUserNotificationSettings(mySettings)
            application.registerForRemoteNotifications()
            
        } else {
            
            print("ios7以前")
            /** iOS8未満での、デバイストークン要求方法 **/
            let type : UIRemoteNotificationType = [.Alert, .Badge, .Sound]
            //通知のタイプを設定
            UIApplication.sharedApplication().registerForRemoteNotificationTypes(type)
            
        }
        
        // DBからtsk_idを読み出して最初の画面を分岐処理(NeesBoardView or LoginView)
        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        if let id = defaults.objectForKey("tsk_id") {
            print("id: \(id) ログイン状態です。")
        } else {
            // ログアウト中ならログイン画面へ
            let storyboard:UIStoryboard =  UIStoryboard(name: "Main",bundle:nil)
            var viewController: UIViewController!
            viewController = storyboard.instantiateViewControllerWithIdentifier("loginViewController") as UIViewController
            window?.rootViewController = viewController
        }
        
        print(defaults.objectForKey("tsk_id"))
        
        // Override point for customization after application launch.
        return true
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        
        print("deviceToken = \(deviceToken)")
        
        var characterSet: NSCharacterSet = NSCharacterSet( charactersInString: "<>" )
        
        var deviceTokenString: String = ( deviceToken.description as NSString )
            .stringByTrimmingCharactersInSet( characterSet )
            .stringByReplacingOccurrencesOfString( " ", withString: "" ) as String
        
        print(deviceTokenString)
        
        
        var server  = "https://kiyo:kiyokiyo@taskeya.com/mobile/pushtest.php"
        var request = NSMutableURLRequest(URL: NSURL(string: server)!)
        request.HTTPMethod = "POST"
        
        // DBから読み出し
        //        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        //        if let id = defaults.objectForKey("tsk_id") {
        //            print("id: \(id) ログイン状態です。")
        //        } else {
        //            print("error")
        //        }
        let myID = "12345678987654321"
        
        // 変数以外の文字列の変更を禁ずる。
        var token = "token=\(deviceTokenString)&id=\(myID)"
        print(token)
        
        request.HTTPBody = token.dataUsingEncoding(NSUTF8StringEncoding)
        
        var response: NSURLResponse?
        
        do {
            let resultData = try NSURLConnection.sendSynchronousRequest(request, returningResponse: &response)
            
            var myData = NSString(data: resultData, encoding: NSUTF8StringEncoding)!
            
            print(myData)
            
        } catch (let e) {
            print(e)
            
        }
    }
    
    // Push通知受信時とPush通知をタッチして起動したときに呼ばれる
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        switch application.applicationState {
        case .Inactive:
            // アプリがバックグラウンドにいる状態で、Push通知から起動したとき
            print("アプリがバックグラウンドにいる状態で、Push通知から起動した")
            break
        case .Active:
            // アプリ起動時にPush通知を受信した
            print("アプリ起動時にPush通知を受信したとき")
            break
        case .Background:
            // アプリがバックグラウンドにいる状態でPush通知を受信した
            print("アプリがバックグラウンドにいる状態でPush通知を受信した")
            break
        }
    }
    
    //    アプリが非Activeになる直前に呼び出される
    func applicationWillResignActive(application: UIApplication) {
        
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    //    アプリが非Activeになりバックグランド実行になった際に呼び出される
    func applicationDidEnterBackground(application: UIApplication) {
        
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    //    2回目以降の起動時に呼び出される(Backgroundにアプリがある場合)
    func applicationWillEnterForeground(application: UIApplication) {
        
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    //    アプリがActiveになった際に呼び出される
    func applicationDidBecomeActive(application: UIApplication) {
        
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    //    システムからのアプリ終了の際に呼び出される
    func applicationWillTerminate(application: UIApplication) {
        
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    //    application:didFinishLaunchingWithOptions
    //    はじめての起動時に呼び出される
    //    application:applicationWillResignActive
    //    アプリが非Activeになる直前に呼び出される
    //    application:applicationDidEnterBackground
    //    アプリが非Activeになりバックグランド実行になった際に呼び出される
    //    application:applicationWillEnterForeground
    //    2回目以降の起動時に呼び出される(Backgroundにアプリがある場合)
    //    application:applicationDidBecomeActive
    //    アプリがActiveになった際に呼び出される
    //    application:applicationWillTerminate
    //    システムからのアプリ終了の際に呼び出される
    
    
}


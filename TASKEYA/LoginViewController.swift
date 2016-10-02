//
//  LoginViewController.swift
//  TASKEYA
//
//  Created by 井上航 on 2016/05/07.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonTapped(sender: UIButton) {
        
        print("login tapped")
        getUserData(emailTextField.text!, pass: passwordTextField.text!)
        
    }
    
    // メアドとパスでログインしたらユーザー情報を取得
    func getUserData(mail: String, pass: String) {
        let requestUrl = "https://kiyo:kiyokiyo@taskeya.com/mobile/?code=kiyocixo113aks331mxhr76567ejxaaa&func=signin&um=" + mail + "&up=" + pass
        print(requestUrl)
        
        Alamofire.request(.GET, requestUrl).responseJSON
            {response in
                
                guard let object = response.result.value else {
                    return
                }
                let json = JSON(object)
                print(json) //ここまで
                
                if let id = json["TSK_ID"].string {
                    print("ログイン成功、tsk_idをDBに格納してプロフィールに画面遷移する")
                    let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
                    defaults.setValue(id, forKey: "tsk_id")
                    defaults.synchronize()
                    // 画面遷移
//                    let storyboard:UIStoryboard =  UIStoryboard(name: "Main",bundle:nil)
                    var viewController: UITabBarController //UIViewController!
                    viewController = self.storyboard!.instantiateViewControllerWithIdentifier("TabBarVC") as! UITabBarController
                    self.presentViewController(viewController, animated: true, completion: nil)
                } else {
                    print("ログイン失敗")
                    self.passwordTextField.placeholder = "パスワードが違います"
                    
                }

                
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

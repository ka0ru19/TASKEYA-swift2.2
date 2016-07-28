//
//  NewRegistrationViewController.swift
//  TASKEYA
//
//  Created by 井上航 on 2016/05/07.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NewRegistrationViewController: UIViewController {
    
    @IBOutlet weak var mailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var pass2Field: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func mailRegistButton(sender: UIButton) {
        if (mailField.text != "") && (passField.text != "") && (pass2Field.text != "") {
            print("3つ揃ってる")
            if passField.text == pass2Field.text {
                print("pass: \(passField.text)")
                if checkMailAddress(mailField.text!) == true {
                    print("\(mailField.text) <-この既に登録されているメールアドレスです。")
                } else {
                    performSegueWithIdentifier("toNR2VC",sender: self)
                }
                
                
            } else {
                print("passField != pass2Field")
            }
            
        } else {
            print("入力不足")
        }
    }
    
    // 既に登録されたメールアドレスに対してtureを返す
    func checkMailAddress(mail: String) -> Bool {
        var result: Bool = false
        
        let request = "https://kiyo:kiyokiyo@taskeya.com/mobile/?code=kiyocixo113aks331mxhr76567ejxaaa&func=existcheck&um=" + mail
        
        Alamofire.request(.GET, request).responseJSON
            {response in
                
                guard let object = response.result.value else {
                    return
                }
                let json = JSON(object)
                result = Bool(json)
                
                print("取得完了")
                
        }
        return result
    }
    
    // Segue 準備
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "toNR2VC" {
            let nextVC: NewRegistration2ViewController = (segue.destinationViewController as? NewRegistration2ViewController)!
            nextVC.mail = mailField.text
            nextVC.pass = passField.text
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

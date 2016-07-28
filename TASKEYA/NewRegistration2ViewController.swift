//
//  NewRestration2ViewController.swift
//  TASKEYA
//
//  Created by 井上航 on 2016/07/23.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NewRegistration2ViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIPickerViewDelegate, UIToolbarDelegate {
    
    var mail: String!
    var pass: String!
    var lName: String!
    var fName: String!
    var gender: String!
    var birth: String!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var genderField: UITextField!
    @IBOutlet weak var birthdayField: UITextField!
    
    var genderToolBar: UIToolbar!
    var dateToolBar: UIToolbar!
    
    var genderPicker: UIPickerView!
    var datePicker : UIDatePicker!
    
    let genderArray = ["男性","女性"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        lastNameTextField.delegate = self
        firstNameTextField.delegate = self
        genderField.delegate = self
        birthdayField.delegate = self
        
        lastNameTextField.tag = 1
        firstNameTextField.tag = 2
        genderField.tag = 3
        birthdayField.tag = 4
        
        
        lastNameTextField.returnKeyType = .Next
        firstNameTextField.returnKeyType = .Next
        
        
        //genderPickerの設定
        genderPicker = UIPickerView()
        genderPicker.showsSelectionIndicator = true
        genderPicker.delegate = self
        genderField.inputView = genderPicker
        
        //genderToolBar作成。ニョキ担当
        genderToolBar = UIToolbar(frame: CGRectMake(0, self.view.frame.size.height/6, self.view.frame.size.width, 40.0))
        genderToolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        genderToolBar.backgroundColor = UIColor.blackColor()
        genderToolBar.barStyle = .BlackTranslucent
        genderToolBar.tintColor = UIColor.whiteColor()
        
        //genderToolBarを閉じるボタンを追加
        let space = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: self, action: nil)
        let genderToolBarButton = UIBarButtonItem(title: "完了", style: .Done, target: self, action: "tappedToolBarBtnDone:")
        genderToolBarButton.tag = 5
        genderToolBar.items = [space, genderToolBarButton]
        genderField.inputAccessoryView = genderToolBar
        
        // datePickerの設定
        datePicker = UIDatePicker()
        datePicker.addTarget(self, action: "changedDateEvent:", forControlEvents: UIControlEvents.ValueChanged)
        datePicker.datePickerMode = UIDatePickerMode.Date
        birthdayField.inputView = datePicker
        
        // dateToolBar作成。ニョキ担当
        dateToolBar = UIToolbar(frame: CGRectMake(0, self.view.frame.size.height/6, self.view.frame.size.width, 40.0))
        dateToolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        dateToolBar.backgroundColor = UIColor.blackColor()
        dateToolBar.barStyle = .BlackTranslucent
        dateToolBar.tintColor = UIColor.whiteColor()
        
        //        //dateToolBarを閉じるボタンを追加
        //        let space = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: self, action: nil)
        //        let dateToolBarBtnDone  = UIBarButtonItem(title: "完了", style: .Done, target: self, action: "tappedToolBarBtnDone:")
        //        //        dateToolBarBtnNext.tag = 3
        //        dateToolBar.items = [space, dateToolBarBtnDone]
        birthdayField.inputAccessoryView = genderToolBar
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 「登録」ボタンが押されたら
    @IBAction func onRegistButtonTapped(sender: UIButton) {
        if (lastNameTextField.text != "") && (firstNameTextField.text != "")
            && (genderField.text != "") && (birthdayField.text != "") {
            print("全項目の入力完了")
            
            lName = lastNameTextField.text
            fName = firstNameTextField.text
            if genderField.text == "男性" {
                gender = "male"
            } else {
                gender = "female"
            }
            birth = birthdayField.text
            
            // Alamofireが漢字を含むURLを受け付けないため、変換。
            var urlString = "https://kiyo:kiyokiyo@taskeya.com/mobile/?code=kiyocixo113aks331mxhr76567ejxaaa&func=signup&uid=" + "none" + "&uf=" + fName + "&ul=" + lName + "&um=" + mail + "&up=" + pass + "&ub=" + birth + "&ug=" + gender
            urlString = urlString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
            
            print(urlString)
            Alamofire.request(.GET, urlString, parameters: nil, encoding: .JSON).responseJSON
                {response in
                    
                    
                    guard let object = response.result.value else {
                        return
                    }
                    let json = JSON(object)
                    print(json)
                    
                    print("取得完了")
                    
                    if let id = json["TSK_ID"].string {
                        print("ログイン成功、tsk_idをDBに格納してプロフィールに画面遷移する")
                        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
                        defaults.setValue(id, forKey: "tsk_id")
                        defaults.synchronize()
                        // 画面遷移
                        let storyboard:UIStoryboard =  UIStoryboard(name: "Main",bundle:nil)
                        var viewController: UITabBarController //UIViewController!
                        viewController = storyboard.instantiateViewControllerWithIdentifier("TabBarVC") as! UITabBarController
                        self.presentViewController(viewController, animated: true, completion: nil)
                    } else {
                        print("ログイン失敗")
                    }
                    
            }
            
            
            
        } else {
            print("入力されていない項目があります。")
        }
    }
    
    // 「完了」を押すと閉じる
    func tappedToolBarBtnDone(sender: UIBarButtonItem) {
        
        
        birthdayField.resignFirstResponder()
    }
    
    func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int {
        return genderArray.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genderArray[row] as? String
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderField.text = genderArray[row] as? String
    }
    
    // datePickerがchangeしたら
    func changedDateEvent(sender:UIDatePicker){
        //        birthdayField.text = String(datePicker.date)
        birthdayField.text = dateToString(datePicker.date)
    }
    
    func dateToString(date:NSDate) ->String {
        let calender: NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        //        let comps: NSDateComponents = calender.components([.Year, .Month, .Day, .Hour, .Minute, .Second, .Weekday] , fromDate: date)
        
        let date_formatter: NSDateFormatter = NSDateFormatter()
        //        var weekdays: [String?] = [nil, "日", "月", "火", "水", "木", "金", "土"]
        date_formatter.locale     = NSLocale(localeIdentifier: "ja_JP")
        date_formatter.dateStyle = .LongStyle
        //        print(String(comps.weekday))
        date_formatter.dateFormat = "yyyy-MM-dd"
        
        
        return date_formatter.stringFromDate(date)
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

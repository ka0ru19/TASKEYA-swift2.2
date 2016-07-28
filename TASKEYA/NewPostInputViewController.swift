//
//  NewPostInputViewController.swift
//  TASKEYA
//
//  Created by 井上航 on 2016/05/05.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

class NewPostInputViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var placePointString: String!
    var mapButtonText: String = "位置情報を追加する"
    
    //    "https://kiyo:kiyokiyo@taskeya.com/mobile/?code=kiyocixo113aks331mxhr76567ejxaaa&func=parseJob&uid=&title=&detail=&cat1=&cat2=&location=&price=&other=&pdates=&deadline="
    
    var id: String!
    var postTitle: String!
    var detail: String!
    var cat1: String!
    var cat2: String!
    var location: String!
    var price: String!
    var other: String!
    var deadline: String!
    
    @IBOutlet weak var postTitleTextField: UITextField!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var limitTextFiled: UITextField!
    @IBOutlet weak var thanksTextField: UITextField!
    @IBOutlet weak var postImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        navigationItem.title = cat2
        
        let ud: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        id = ud.objectForKey("tsk_id") as? String
        
        // 位置情報の初期化
        if let placeAdress = ud.objectForKey("placeAdress") as? String {
            ud.removeObjectForKey("placeAdress")
            print("キーplaceAdressを削除")
        } else {
            print("ud.objectForKey(\"placeAdress\") as! String がありませんでした。")
        }
        if let placeAdress = ud.objectForKey("placePoint") as? String {
            ud.removeObjectForKey("placePoint")
            print("キーplacePointを削除")
        } else {
            print("ud.objectForKey(\"placePoint\") as! String がありませんでした。")
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidDisappear(animated)
        //        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let ud: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        print("viewDidAppearが呼ばれました。")
        
        if let adress = ud.objectForKey("placeAdress") as? String {
            print(adress)
            mapButtonText = adress
            placePointString = ud.objectForKey("placePoint") as? String
            print(placePointString)
            
            location = placePointString
        }
        
        
        // mapボタンのタイトルを住所に変更
        let button: UIButton = view.viewWithTag(1) as! UIButton
        button.setTitle(mapButtonText, forState: .Normal)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 「次へ」
    @IBAction func nextButtonTapped(sender: UIButton) {
        postTitle = postTitleTextField.text
        detail = detailTextView.text
        
        price = thanksTextField.text
        other = ""
        deadline = limitTextFiled.text
        
        print(postTitle)
        print(detail)
        print(cat1)
        print(cat2)
        print(location)
        print(price)
        print(other)
        print(deadline)
        
        let url = "https://kiyo:kiyokiyo@taskeya.com/mobile/?code=kiyocixo113aks331mxhr76567ejxaaa&func=parseJob&uid="
            + id + "&title=" + postTitle + "&detail=" + detail + "&cat1=" + cat1 + "&cat2=" + cat2 + "&location="
            + location + "&price=" + price + "&other=&pdates=&deadline=" + deadline
        print(url)
        
//        print("https://kiyo:kiyokiyo@taskeya.com/mobile/?code=kiyocixo113aks331mxhr76567ejxaaa&func=parseJob&uid="
//            + id)
//        print("https://kiyo:kiyokiyo@taskeya.com/mobile/?code=kiyocixo113aks331mxhr76567ejxaaa&func=parseJob&uid="
//            + id + "&title=" + postTitle)
//        print("https://kiyo:kiyokiyo@taskeya.com/mobile/?code=kiyocixo113aks331mxhr76567ejxaaa&func=parseJob&uid="
//            + id + "&title=" + postTitle + "&detail=" + detail)
//        print("https://kiyo:kiyokiyo@taskeya.com/mobile/?code=kiyocixo113aks331mxhr76567ejxaaa&func=parseJob&uid="
//            + id + "&title=" + postTitle + "&detail=" + detail + "&cat1=" + cat1 + "&cat2=" + cat2)
//        print("https://kiyo:kiyokiyo@taskeya.com/mobile/?code=kiyocixo113aks331mxhr76567ejxaaa&func=parseJob&uid="
//            + id + "&title=" + postTitle + "&detail=" + detail + "&cat1=" + cat1 + "&cat2=" + cat2 + "&location="
//            + location)
//        print("https://kiyo:kiyokiyo@taskeya.com/mobile/?code=kiyocixo113aks331mxhr76567ejxaaa&func=parseJob&uid="
//            + id + "&title=" + postTitle + "&detail=" + detail + "&cat1=" + cat1 + "&cat2=" + cat2 + "&location="
//            + location + "&price=" + price)
//        print("https://kiyo:kiyokiyo@taskeya.com/mobile/?code=kiyocixo113aks331mxhr76567ejxaaa&func=parseJob&uid="
//                   + id + "&title=" + postTitle + "&detail=" + detail + "&cat1=" + cat1 + "&cat2=" + cat2 + "&location="
//                   + location + "&price=" + price + "&other=&pdates=&deadline=" + deadline)
//        print(url)
        
        //        postRequest()
    }
    
    func postRequest() {
        //        let url = NSURL(string: "https://taskeya.com/final/user/sample.php")
        //        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        //        let session = NSURLSession(configuration: config)
        //        let req = NSMutableURLRequest(URL: url!)
        //        req.HTTPMethod = "POST"
        //        req.HTTPBody = "name=Jack".dataUsingEncoding(NSUTF8StringEncoding)
        //        let task = session.dataTaskWithRequest(req, completionHandler: {
        //            (data, resp, err) in
        //            print(resp!.URL!)
        //            print(NSString(data: data!, encoding: NSUTF8StringEncoding))
        //        })
        //        task.resume()
        
        print("送信完了")
        
        //        "https://kiyo:kiyokiyo@taskeya.com/mobile/?code=kiyocixo113aks331mxhr76567ejxaaa&func=parseJob&uid=&title=&detail=&cat1=&cat2=&location=&price=&other=&pdates=&deadline="
    }
    
    // カメラ、アルバムの呼び出しメソッド(カメラorアルバムのソースタイプが引き数)
    func precentPickerController(sourceType: UIImagePickerControllerSourceType) {
        
        // ライブラリが使用できるかどうか判定
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            
            // UIImagePickerControllerをインスタンス化
            let picker = UIImagePickerController()
            
            // ソースタイプを設定
            picker.sourceType = sourceType
            
            // デリゲートを設定
            picker.delegate = self
            
            self.presentViewController(picker, animated: true, completion: nil)
        }
    }
    
    // 写真が選択された時に呼び出されるメソッド
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
        // 画像を出力
        postImageView.image = image
    }
    
    //「画像を取得」ボタンを押した時に呼ばれるメソッド
    @IBAction func selectButtonTapped(sender: UIButton) {
        
        // 選択肢の上に表示するタイトル、メッセージ、アラートタイプの設定
        let alertController = UIAlertController(title: "画像の取得先を選択", message: nil, preferredStyle: .ActionSheet)
        
        // 選択肢の名前と処理を１つずつ設定
        let firstAction = UIAlertAction(title: "カメラ", style: .Default) {
            action in
            self.precentPickerController(.Camera)
        }
        let secondAction = UIAlertAction(title: "アルバム", style: .Default) {
            action in
            self.precentPickerController(.PhotoLibrary)
        }
        let cancelAction = UIAlertAction(title: "キャンセル", style: .Cancel, handler: nil)
        
        // 設定した選択肢をアラートに登録
        alertController.addAction(firstAction)
        alertController.addAction(secondAction)
        alertController.addAction(cancelAction)
        
        // アラートを表示
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func placeButtonTapped(sender: UIButton) {
        
        performSegueWithIdentifier("toMapVC",sender: nil)
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

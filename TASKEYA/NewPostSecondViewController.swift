//
//  NewPostSecondViewController.swift
//  TASKEYA
//
//  Created by 井上航 on 2016/05/05.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

class NewPostSecondViewController: UIViewController {
    
    let cat1Array = ["知恵求む","助け求む","仲間求む","応援求む"]
    let buttonCat2Array = [
        ["オススメを聞く","教えてもらう","アンケート","オリジナル"],
        ["助け１","教え２","教え３","教え４"],
        ["仲間１","アンケ２","アンケ３","アンケ４"],
        ["応援１","オリ２","オリ３","オリ４"]
    ]
    
//    let titleArray: [String] = ["知恵求む","助け求む","仲間求む","応援求む"]
//    var topTitle: String! // 前の画面から受け渡される(cat1)
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    var displayID: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        
        button1.tag = 1
        button2.tag = 2
        button3.tag = 3
        button4.tag = 4
        
        // 前のVCで選択されたボタンを元にこのViewにボタンのタイトルを設定
        button1.setTitle(buttonCat2Array[displayID][0], forState: .Normal)
        button2.setTitle(buttonCat2Array[displayID][1], forState: .Normal)
        button3.setTitle(buttonCat2Array[displayID][2], forState: .Normal)
        button4.setTitle(buttonCat2Array[displayID][3], forState: .Normal)
        
        titleLabel.text = cat1Array[displayID]
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btn1Tapped(sender: UIButton) {
        performSegueWithIdentifier("toNewPostInputVC",sender: sender)
    }
    
    @IBAction func btn2Tapped(sender: UIButton) {
        performSegueWithIdentifier("toNewPostInputVC",sender: sender)
    }
    
    @IBAction func btn3Tapped(sender: UIButton) {
        performSegueWithIdentifier("toNewPostInputVC",sender: sender)
    }
    
    @IBAction func btn4Tapped(sender: UIButton) {
        performSegueWithIdentifier("toNewPostInputVC",sender: sender)
    }
    
    // Segue 準備
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toNewPostInputVC" {
            let nextVC: NewPostInputViewController = (segue.destinationViewController as? NewPostInputViewController)!
            nextVC.cat1 = titleLabel.text
            nextVC.cat2 = buttonCat2Array[displayID][sender!.tag - 1] // これを次の画面のタイトルに出力
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

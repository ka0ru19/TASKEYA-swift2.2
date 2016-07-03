//
//  NewPostSecondViewController.swift
//  TASKEYA
//
//  Created by 井上航 on 2016/05/05.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

class NewPostSecondViewController: UIViewController {
    
    var buttonLabel: [[String]] = [["オススメを聞く","教えてもらう","アンケート","オリジナル"],
                                       ["助け１","教え２","教え３","教え４"],
                                       ["仲間１","アンケ２","アンケ３","アンケ４"],
                                       ["応援１","オリ２","オリ３","オリ４"]
    ]
    
    let titleArray: [String] = ["知恵求む","助け求む","仲間求む","応援求む"]
    @IBOutlet weak var titleLabel: UILabel!
    var displayID: Int!
    var tagNumber2: Int!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        
        // 前のVCで選択されたボタンを元にこのViewにボタンのタイトルを設定
        for i in 0 ..< 4{
        let button: UIButton = view.viewWithTag(i+1) as! UIButton
        button.setTitle(buttonLabel[displayID-1][i], forState: .Normal)
        }
        
        titleLabel.text = titleArray[displayID-1]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btn1Tapped(sender: UIButton) {
        tagNumber2 = 1
        performSegueWithIdentifier("toNewPostInputVC",sender: nil)
    }
    
    @IBAction func btn2Tapped(sender: UIButton) {
        tagNumber2 = 2
        performSegueWithIdentifier("toNewPostInputVC",sender: nil)
    }
    
    @IBAction func btn3Tapped(sender: UIButton) {
        tagNumber2 = 3
        performSegueWithIdentifier("toNewPostInputVC",sender: nil)
    }
    
    @IBAction func btn4Tapped(sender: UIButton) {
        tagNumber2 = 4
        performSegueWithIdentifier("toNewPostInputVC",sender: nil)
    }
    
    // Segue 準備
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "toNewPostInputVC" {
            let nextVC: NewPostInputViewController = (segue.destinationViewController as? NewPostInputViewController)!
            // SubViewController のselectedImgに選択された画像を設定する
            //            nextVC.userImage = userImage
            nextVC.navigationbarTitle = buttonLabel[displayID-1][tagNumber2-1]
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

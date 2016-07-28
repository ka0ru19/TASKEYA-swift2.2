//
//  NewPostFirstViewController.swift
//  TASKEYA
//
//  Created by 井上航 on 2016/05/05.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit
import Alamofire

class NewPostFirstViewController: UIViewController {
    
    //    var tagNumber1: Int!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    
    let cat1Array = ["知恵求む","助け求む","仲間求む","応援求む"]
    var pushedRow: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        
        button1.tag = 1
        button2.tag = 2
        button3.tag = 3
        button4.tag = 4
        
        button1.setTitle(cat1Array[0], forState: .Normal)
        button2.setTitle(cat1Array[1], forState: .Normal)
        button3.setTitle(cat1Array[2], forState: .Normal)
        button4.setTitle(cat1Array[3], forState: .Normal)
        
        button1.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button3.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btn1Tapped(sender: UIButton) {
        performSegueWithIdentifier("toNewPostSecondVC",sender: sender)
    }
    
    @IBAction func btn2Tapped(sender: UIButton) {
        performSegueWithIdentifier("toNewPostSecondVC",sender: sender)
    }
    
    @IBAction func btn3Tapped(sender: UIButton) {
        performSegueWithIdentifier("toNewPostSecondVC",sender: sender)
    }
    
    @IBAction func btn4Tapped(sender: UIButton) {
        performSegueWithIdentifier("toNewPostSecondVC",sender: sender)
    }
    
    
    // Segue 準備
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
                print(sender!.tag)
        if segue.identifier == "toNewPostSecondVC" {
            let nextVC: NewPostSecondViewController = (segue.destinationViewController as? NewPostSecondViewController)!
//            nextVC.titleLabel.text = cat1Array[sender!.tag - 1]
            nextVC.displayID = sender!.tag - 1 // 1~4 -> 0~3
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

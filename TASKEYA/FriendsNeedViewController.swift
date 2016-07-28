//
//  FriendsNeedViewController.swift
//  TASKEYA
//
//  Created by 井上航 on 2016/05/05.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FriendsNeedViewController: UIViewController {
    
    var post: Post!
    var work: Work!
    
    var postImage: UIImage?
    var userImage: UIImage!
    var userName: String = ""
    var postTitle: String = ""
    var postDetail: String = ""
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var postTextView: UITextView!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tanksLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        work = Work(workId: post.workID)
        
        print(work)
        // Do any additional setup after loading the view.
        
        postImageView.image = nil
        userImageView.image = work.w_ProfileURL //post.userImage
        userNameLabel.text = work.w_RequesterName //post.userName
        titleLabel.text = work.w_Title
        postTextView.text = work.w_Detail
        placeLabel.text = String(work.w_Location) //"ppp^place"
        timeLabel.text = String(work.w_C_Deadline) //"ttt^time"
        tanksLabel.text = String(work.w_Price) //"thanks^thanks"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onApplyButtonTapped(sender: UIButton) {
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

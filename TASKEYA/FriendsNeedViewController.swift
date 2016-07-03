//
//  FriendsNeedViewController.swift
//  TASKEYA
//
//  Created by 井上航 on 2016/05/05.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

class FriendsNeedViewController: UIViewController {
    
    var post: Post!
    
    var postImage: UIImage?
    var userImage: UIImage!
    var userName: String = ""
    var postTitle: String = ""
    var postDetail: String = ""
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postTextView: UITextView!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tanksLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        postImageView.image = nil
        userImageView.image = post.userImage
        userNameLabel.text = post.userName
        postTextView.text = String(post.userImage)
        placeLabel.text = "ppp^place"
        timeLabel.text = "ttt^time"
        tanksLabel.text = "thanks^thanks"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

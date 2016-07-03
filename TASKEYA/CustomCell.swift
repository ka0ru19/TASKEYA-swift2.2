//
//  CustomCell.swift
//  TASKEYA
//
//  Created by 井上航 on 2016/05/12.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

class CustomCell: UICollectionViewCell {
    @IBOutlet var imgSample:UIImageView!
    @IBOutlet var lblSample:UILabel!
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
    }

}

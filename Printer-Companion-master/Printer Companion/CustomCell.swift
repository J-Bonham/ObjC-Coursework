//
//  CustomCell.swift
//  Printer Companion
//
//  Created by Jeremiah Bonham on 10/3/15.
//  Copyright © 2015 Jeremiah Bonham. All rights reserved.
//

import UIKit
import Parse


class CustomCell: UITableViewCell, UITableViewDelegate {

    var parseObject:PFObject?
    
    @IBOutlet var img: UIImageView!
    @IBOutlet var label: UILabel!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var user: UILabel!
    @IBOutlet var likedByLabel: UILabel!
    
    var likedBy : [String]!
    var likedByCount : Int!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //likedByLabel.hidden = false
        //likedByCount = 0
        // Initialization code
  
    }



    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

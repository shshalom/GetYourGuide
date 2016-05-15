//
//  ReviewTableViewCell.swift
//  GetYourGuide
//
//  Created by Shalom Shwaitzer on 13/05/2016.
//  Copyright © 2016 Shalom Shwaitzer. All rights reserved.

import UIKit

class ReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var commentView: UILabel!
    
    
   override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
        usernameLabel.adjustsFontSizeToFitWidth = true
        usernameLabel.numberOfLines = 0
        usernameLabel.lineBreakMode = .ByTruncatingTail
//        self.avatarImageView.layer.masksToBounds = true
//        self.avatarImageView.layer.cornerRadius = (avatarImageView.frame.size.height) / 2
//        self.avatarImageView.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindDataBy(review: Review) {
        avatarImageView.tag = review.reviewId
        commentView.text = review.message
        usernameLabel.text = review.author
        //avatarImageView.sd_setImageWithURL(NSURL(string: review.avatar)!)
        
    }
    
}

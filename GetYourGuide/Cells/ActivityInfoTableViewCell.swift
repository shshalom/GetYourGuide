//
//  ActivityInfoTableViewCell.swift
//  GetYourGuide
//
//  Created by Shalom Shwaitzer on 13/05/2016.
//  Copyright © 2016 Shalom Shwaitzer. All rights reserved.


import UIKit

class ActivityInfoTableViewCell: UITableViewCell {
    

    @IBOutlet weak var descript: UITextView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var more: UIButton!
    @IBOutlet weak var share: UIButton!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var views: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindDataBy(activityInfo: Activity) {
        let attrStr = try! NSAttributedString(
            data: "<html><body>\(activityInfo.desc)</body></html>".dataUsingEncoding(NSUnicodeStringEncoding, allowLossyConversion: true)!,
            options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
            documentAttributes: nil)
        descript.attributedText = attrStr
        
        
        likeLabel.text = "\(activityInfo.likesCount) Likes"
        views.text = "\(activityInfo.viewsCount) Views"
        if activityInfo.liked {
            likeBtn.setImage(UIImage(named: "ic_like_highlight"), forState: .Normal)
        }

    }
    
    override func prepareForReuse() {
        descript.attributedText = nil
        likeLabel.text = nil
        
    }
    
}

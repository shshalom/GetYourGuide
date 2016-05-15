//
//  ActivityTableViewCell.swift
//  GetYourGuide
//
//  Created by Shalom Shwaitzer on 14/05/2016.
//  Copyright © 2016 Shalom Shwaitzer. All rights reserved.
//

import UIKit

class ActivityTableViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var activityImageView:UIImageView!
    @IBOutlet weak var activityTitle:UILabel!
    @IBOutlet weak var activityDecription:UILabel!
    @IBOutlet weak var activityRating:FloatRatingView!
    
    var activity:Activity?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func bindDataBy(activityInfo: Activity) {
        
        //return
        activity = activityInfo
        
        activityImageView.setImageWithURL(NSURL(string: activityInfo.thumbURL)!, usingActivityIndicatorStyle: .Gray)
        activityImageView.contentMode = .ScaleAspectFill
  
        activityTitle.text = activityInfo.title
        activityTitle.adjustsFontSizeToFitWidth = true
        activityTitle.textAlignment = .Center
        activityTitle.numberOfLines = 0
        
        
        let attrStr = try! NSAttributedString(
            data: "<html><body>\(activityInfo.desc)</body></html>".dataUsingEncoding(NSUnicodeStringEncoding, allowLossyConversion: true)!,
            options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType ],
            documentAttributes: nil)
        activityDecription.attributedText = attrStr
        
        activityRating.rating = activity!.rating
        
    }
    
    override func prepareForReuse() {
        //activity = nil
    }

    
    
}

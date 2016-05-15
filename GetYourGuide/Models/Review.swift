//
//  Comment.swift
//  Pixel
//
//  Created by SongFei on 15/12/4.
//  Copyright © 2015年 SongFei. All rights reserved.
//

import UIKit
import SwiftyJSON

class Review: NSObject {
    
    static let REVIEWS_PER_PAGE = 5
    
    let reviewId: Int
    let rating:Float
    let title:String
    let message: String
    let author: String
    let avatar: String
    let foreignLanguage:Bool
    let date:String
    let dateUnformated:NSDate?
    let languageCode:String
    let travlerType:Int?
    
    
    init?(data: JSON) {
        
        if let id = data["review_id"].int,
            rating = data["rating"].string,
            title = data["title"].string,
            message = data["message"].string,
            author = data["author"].string {
            
            self.reviewId        = id
            self.rating          = Float(rating)!
            self.title           = title
            self.message         = message
            self.author          = author
            self.foreignLanguage = data["foreignLanguage"].bool!
            self.date            = data["date"].string!
            self.dateUnformated  = nil
            self.languageCode    = data["languageCode"].string!
            self.travlerType     = nil //data["traveler_type"].int!
            
            // parse image url
            self.avatar          = ""
            
            
            
        }else{
            return nil
        }
    }
   
    
    
}

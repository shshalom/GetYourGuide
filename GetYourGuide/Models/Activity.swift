//
//  Activity.swift
//  GetYourGuide
//
//  Created by Shalom Shwaitzer on 13/05/2016.
//  Copyright © 2016 Shalom Shwaitzer. All rights reserved.


import Foundation
import SwiftyJSON
import CrossroadRegex

class Activity: NSObject {
    
    var activityId:String = "berlin-l17"
    var tourId:String     = "tempelhof-2-hour-airport-history-tour-berlin-airlift-more-t23776"
    var thumbURL:String   = ""
    var title:String      = "Berlin - 2 Hour Airport Tour"
    var likesCount:Int    = 10
    var viewsCount:Int    = 1040
    var commentsCount:Int = 200
    var liked:Bool        = true
    var desc: String      = ""
    var rating:Float      = 0
    
    init?(match: Match) {
        
        super.init()
        
        self.activityId = match.group("location")!
        self.tourId     = match.group("activity")!
        self.thumbURL   = strip(match.group("thumb")!)
        self.title      = strip(match.group("title")!)
        self.rating     = Float(match.group("rating")!)!
        self.commentsCount = Int(match.group("reviewcount")!)!
        self.desc       = match.group("description")!
        
    }
    
    private func strip(string:String)->String {
        
        return  ("\"|\t|\n".r?.replaceAll(string, replacement: ""))!

    }
    
    static func arrayFromRawJSON(data:AnyObject)->MatchSequence? {
        
       let pattern = "article.*?data-href.*?\\.com/(.*?)/(.*?)/.*?<img.*?src.*?=(.*?)\\s+.*?card-title.*?>(.*?)<.*?Rating:\\s*(\\d+\\.*\\d*).*?rating-total.*?>(\\d+).*?description.*?>(.*?)<"
        
        let htmlString = data["activities"] as! String

        let regex:RegexType = try! Regex(pattern:pattern,
                                        groupNames:"location", "activity", "thumb","title","rating","reviewcount","description")
        
        return regex.findAll(htmlString)
        
    }
    
    
}


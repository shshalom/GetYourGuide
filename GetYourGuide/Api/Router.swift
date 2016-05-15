//
//  Router.swift
//  GetYourGuide
//
//  Created by Shalom Shwaitzer on 13/05/2016.
//  Copyright © 2016 Shalom Shwaitzer. All rights reserved.
//

import UIKit
import Alamofire

enum Router: URLRequestConvertible {
    
    static let baseURLString = "https://getyourguide.com"
    static let consumerKey   = ""
    
    static let manager: Manager = {
        
            let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
            let defaultHeaders = Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders
            configuration.HTTPAdditionalHeaders = defaultHeaders
            configuration.requestCachePolicy = .UseProtocolCachePolicy // this is the default
            configuration.URLCache = NSURLCache.sharedURLCache()
            
            // Create your own manager instance that uses your custom configuration
            return Alamofire.Manager(configuration:configuration)
        
    }()
    
    case PopularActivities(String)
    case Reviews(Activity ,Int,Int)
    case AddReview(Activity,String,Float)
    
    private var method: Alamofire.Method {
        switch self {
            case .AddReview(_, _, _):
                return .POST
            default:
                return .GET
        }
    }
    
    var URLRequest: NSMutableURLRequest {
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        //future api usage.
        var oauthToken: String = ""
        if let accessToken = userDefaults.valueForKey("accessToken") {
            oauthToken = accessToken as! String
        }
        
        let result: (path: String, parameters: [String: AnyObject]) = {
            switch self {
            
                case .PopularActivities(let query):
                    let params = ["q":"\(query)"]
                    return ("/s/search.json", params)
            
                case .Reviews(let activity, let commentsPage, let rating):
                
                    let params = [
                        "count":"\(Review.REVIEWS_PER_PAGE)",
                        "rating":"\(rating)",
                        "direction":"DESC",
                        "page": "\(commentsPage)"
                    ]
                    return ("/\(activity.activityId)/\(activity.tourId)/reviews.json", params)
                
                case .AddReview(let activity, let reviewBody, let rating):
                let params = [
                    "consumer_key": Router.consumerKey,
                    "oauth_token": oauthToken,
                    "rating":"\(rating)",
                    "body": reviewBody
                ]
                return ("/\(activity.activityId)/\(activity.tourId)/", params)
            
            }
        }()
        
    
        let URL = NSURL(string: Router.baseURLString)!
        let URLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(result.path))
            URLRequest.HTTPMethod = method.rawValue
        let encoding = Alamofire.ParameterEncoding.URL
        
        
        return encoding.encode(URLRequest, parameters: result.parameters).0
    }
}
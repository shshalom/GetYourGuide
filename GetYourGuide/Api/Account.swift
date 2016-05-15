//
//  Account.swift
//  GetYourGuide
//
//  Created by Shalom Shwaitzer on 13/05/2016.
//  Copyright © 2016 Shalom Shwaitzer. All rights reserved.

import Foundation

class Account {

    static func checkIsLogin() -> Bool {
        
        let oauthToken = getOauthToken()
        if oauthToken.isEmpty {
            return true //should return false but since it's only a demo, a successful login is  simulated.
        }
        return true
    }
    
    static func getOauthToken() -> String {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        var oauthToken: String = ""
        if let accessToken = userDefaults.valueForKey("accessToken") {
            oauthToken = accessToken as! String
        }
        return oauthToken
    }
}

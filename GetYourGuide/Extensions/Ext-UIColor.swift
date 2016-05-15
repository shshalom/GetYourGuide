//
//  Ext-UIColor.swift
//  GetYourGuide
//
//  Created by Shalom Shwaitzer on 13/05/2016.
//  Copyright © 2016 Shalom Shwaitzer. All rights reserved.
//

import Foundation



extension UIColor {
    
    struct colorScheme {
        static func navigationBarColor()->UIColor {
            return UIColor(red: 255.0/255.0, green: 61.0/255.0, blue: 0/255.0, alpha: 1.0)
        }
        
        static func viewBackgroundColor()->UIColor {
            return UIColor(red: 255.0/255.0, green: 61.0/255.0, blue: 0/255.0, alpha: 1.0)
        }
        
        static func bottomMenuHairlineColor()->UIColor {
            return UIColor(red: 255.0/255.0, green: 61.0/255.0, blue: 0/255.0, alpha: 1.0)
        }
        
        static func selectionIndicatorColor()->UIColor {
            return UIColor(red: 255.0/255.0, green: 61.0/255.0, blue: 0/255.0, alpha: 0.5)
        }
        
        static func selectedMenuItemLabel()->UIColor {
            return UIColor(red: 18.0/255.0, green: 150.0/255.0, blue: 225.0/255.0, alpha: 1.0)
        }
        
        static func unselectedMenuItemLabel()->UIColor {
            return UIColor(red: 40.0/255.0, green: 40.0/255.0, blue: 40.0/255.0, alpha: 1.0)
        }
        
    }
    
    static func randomColor() -> UIColor {
        let r = CGFloat.random()
        let g = CGFloat.random()
        let b = CGFloat.random()
        
        // If you wanted a random alpha, just create another
        // random number for that too.
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
}

//
//  UIStoryboardExtenstion.swift
//  Dsigner
//
//  Created by Shalom Shwaitzer on 2/1/15.
//  Copyright (c) 2015 DropicoMedia. All rights reserved.
//

import UIKit
extension UIStoryboard {
   
    class func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: nil) }
    
    class func mainNavigationController()-> UINavigationController? { return mainStoryboard().instantiateViewControllerWithIdentifier("MainNavigationController") as? UINavigationController }
    
    class func detailActivityViewController() -> DetailActivityViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("DetailActivityViewController") as? DetailActivityViewController
    }
    
    
    class func activityCollectionViewController() -> ActivityCollectionViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("ActivityCollectionViewController") as? ActivityCollectionViewController
    }
    
}

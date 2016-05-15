//
//  Ext-CGFloat.swift
//  CCLable
//
//  Created by Shalom Shwaitzer on 17/04/2016.
//  Copyright © 2016 Shalom Shwaitzer. All rights reserved.
//

import UIKit

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
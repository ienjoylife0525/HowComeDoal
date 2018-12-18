//
//  HCUIColorExtension.swift
//  HowComeDoal
//
//  Created by Patato on 2018/12/18.
//  Copyright © 2018 Patato. All rights reserved.
//

import UIKit

extension UIColor {
    class func rgb(_ fromHex: Int) -> UIColor {
        let red = CGFloat((fromHex & 0xFF0000) >> 16) / 0xFF
        let green = CGFloat((fromHex & 0x00FF00) >> 8) / 0xFF
        let blue = CGFloat(fromHex & 0x0000FF) / 0xFF
        let alpha = CGFloat(1.0)
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}

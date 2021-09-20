//
//  UIColor+Extension.swift
//  LoginModule
//
//  Created by Keerthi on 21/08/21.
//

import UIKit

extension UIColor {
    
    //Hex string to UIColor
    public func colorFromHex(hex: String) -> UIColor {
        var hexStr = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexStr.hasPrefix("#") {
            hexStr.remove(at: hexStr.startIndex)
        }
        
        if (hexStr.count) != 6 {
            return UIColor.black
        }
        
        var rgbValue: UInt32 = 0
        Scanner(string: hexStr).scanHexInt32(&rgbValue)
        
        return UIColor.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                            alpha: CGFloat(1.0))
    }
}

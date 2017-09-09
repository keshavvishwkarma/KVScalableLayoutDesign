//
//  UIScreen+Extension.swift
//  ScalableLayoutDesign
//
//  Created by Keshav on 7/21/17.
//  Copyright © 2017 Keshav. All rights reserved.
//

import UIKit

public enum Screen {
    case iPhone5
    case iPhone6
    case iPhone6Plus
    case iPhoneSE
    case iPhoneScreen(CGSize)
}

public extension UIScreen {
    /// Retrieves the device width.
    public var width: CGFloat {
        return min(bounds.width, bounds.height)
    }
    
    /// Retrieves the device height.
    public var height: CGFloat {
        return max(bounds.width, bounds.height)
    }
    
    /// Retrieves the device size.
    public static var size: CGSize {
        return CGSize(width: UIScreen.main.width, height:UIScreen.main.height)
    }
    
    static var iPhone5Size: CGSize {
        return CGSize(width: 320, height: 568.0)
    }
    
    static var iPhone6Size: CGSize {
        return CGSize(width: 375, height: 667)
    }
    
    static var iPhone6PlusSize: CGSize {
        return CGSize(width:414.0, height: 736)
    }
}

extension Screen
{
    public var size: CGSize {
        switch self {
         case .iPhone5:     return UIScreen.iPhone5Size
         case .iPhoneSE:    return UIScreen.iPhone5Size
         case .iPhone6:     return UIScreen.iPhone6Size
         case .iPhone6Plus: return UIScreen.iPhone6PlusSize
         case let .iPhoneScreen(size): return size
        }
    }
    
    public func scaledWidth( value:CGFloat, destScreen:Screen = .iPhoneScreen(UIScreen.size))->CGFloat {
        let widthFraction = destScreen.size.width / size.width
        DefaultLogger.logger.log("widthFraction: " + widthFraction.description + " widthscale: " + (value*widthFraction).description )
        return value*widthFraction
    }
    
    public func scaledHeight( value:CGFloat, destScreen:Screen = .iPhoneScreen(UIScreen.size))->CGFloat {
        let heightFraction = destScreen.size.height / size.height
        DefaultLogger.logger.log("heightFraction: " + heightFraction.description + " heightScale: " + (value*heightFraction).description )
        return value*heightFraction
    }
    
}

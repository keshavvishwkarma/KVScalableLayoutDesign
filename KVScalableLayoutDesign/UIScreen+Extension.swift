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
    case iPhoneScreenSize(CGFloat, CGFloat)
    
    var size: CGSize {
        
        switch self {
        case .iPhone5:     return UIScreen.iPhone5Size
        case .iPhoneSE:    return UIScreen.iPhone5Size
        case .iPhone6:     return UIScreen.iPhone6Size
        case .iPhone6Plus: return UIScreen.iPhone6PlusSize
        case let .iPhoneScreenSize(w, h): return CGSize(width: w, height: h)
        }
        
    }
    
    public func scaledWidth( value:CGFloat)->CGFloat {
        let widthFraction = UIScreen.main.width / size.width
        
        print("widthFraction: " + widthFraction.description + "widthscale: " + (value*widthFraction).description )
        return value*widthFraction
    }
    
    public func scaledHeight(value:CGFloat)->CGFloat {
        let heightFraction = UIScreen.main.height / size.height
        print("heightFraction: " + heightFraction.description + "heightScale: " + (value*heightFraction).description )
        return value*heightFraction
    }
    
}

public extension UIScreen
{
    /// Retrieves the device width.
    public var width: CGFloat {
        return min(bounds.width, bounds.height)
    }
    
    /// Retrieves the device height.
    public var height: CGFloat {
        return max(bounds.width, bounds.height)
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

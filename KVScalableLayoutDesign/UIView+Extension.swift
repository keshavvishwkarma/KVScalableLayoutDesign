//
//  UIView+Extension.swift
//  ScalableLayoutDesign
//
//  Created by Keshav on 7/21/17.
//  Copyright © 2017 Keshav. All rights reserved.
//

import UIKit

extension UIView {
    
    public func scaledLayoutDesign(from srcScreen: Screen = .iPhone6) {
        self.traceConstraint(basedOn: srcScreen)
        scaledFont(by: srcScreen.scaledWidth( value: 1))
        for v in subviews {
            v.scaledLayoutDesign(from: srcScreen)
        }
    }
    
    public func scaledFontSize(from srcScreen: Screen = .iPhone6) {
        scaledFont(by: srcScreen.scaledWidth( value: 1))
    }
    
}

extension UIView {
    
    // Implemnted by It's subclasses
    public func scaledFont(by ratio: CGFloat) {
        //...
        DefaultLogger.logger.log(#function, self)
    }
    
}

extension UILabel {
    public override func scaledFont(by ratio: CGFloat) {
        font = font.scaledFont(by: ratio)
    }
}

extension UIButton {
    public override func scaledFont(by ratio: CGFloat) {
        self.titleLabel?.scaledFont(by: ratio)
    }
}

extension UITextField {
    public override func scaledFont(by ratio: CGFloat) {
        font = font?.scaledFont(by: ratio)
    }
}

extension UITextView {
    public override func scaledFont(by ratio: CGFloat) {
        font = font?.scaledFont(by: ratio)
    }
}

extension UIFont {
    fileprivate func scaledFont(by ratio: CGFloat) -> UIFont {
        return UIFont(name: fontName, size: pointSize * ratio)!
    }
}

extension NSAttributedString
{
    public func scaledContent(from srcScreen: Screen = .iPhone6) -> NSAttributedString {
        return scaledContent(by: srcScreen.scaledWidth( value: 1))
    }
    
    public func scaledContent(by ratio: CGFloat) -> NSAttributedString {
        let mutable = mutableCopy() as! NSMutableAttributedString
        mutable.scaledMutableContent(by: ratio)
        return mutable
    }
    
}

extension NSMutableAttributedString
{
    public func scaledContent(from srcScreen: Screen = .iPhone6) {
        return scaledMutableContent(by: srcScreen.scaledWidth( value: 1))
    }
    
    public func scaledMutableContent(by ratio: CGFloat) {
        beginEditing()
        enumerateAttributes(in: NSRange(location: 0, length: length), options: []) { (attributes, range, _) in
            var styleAttributes = attributes
            if let font = styleAttributes[NSFontAttributeName] as? UIFont {
                self.removeAttribute(NSFontAttributeName, range: range)
                self.addAttribute(NSFontAttributeName, value: font.scaledFont(by: ratio), range: range)
            }
            
            if let textAttachment = styleAttributes[NSAttachmentAttributeName] as? NSTextAttachment {
                guard let attachedImage : UIImage  = textAttachment.image else { return }
                let scaledImage = attachedImage.resize(toWidth: CGFloat(attachedImage.size.width*ratio))
                textAttachment.image = scaledImage
            }
        }
        self.endEditing()
    }
    
}

extension UIView
{
    fileprivate func traceConstraint(basedOn srcScreen: Screen)
    {
        for cons in constraints
        {
            if cons.firstAttribute == .height && cons.secondAttribute == .notAnAttribute
            {
                DefaultLogger.logger.log("V - Height");
                cons.constant = srcScreen.scaledHeight( value: cons.constant)
            }
            else if cons.firstAttribute == .bottom || cons.secondAttribute == .bottom
            {
                DefaultLogger.logger.log("V - Bottom");
                cons.constant = srcScreen.scaledHeight( value: cons.constant)
            }
            else if cons.firstAttribute == .top || cons.secondAttribute == .top
            {
                DefaultLogger.logger.log("V - Top");
                cons.constant = srcScreen.scaledHeight( value: cons.constant)
            }
            else if cons.firstAttribute == .bottom && cons.secondAttribute == .top || cons.firstAttribute == .bottom && cons.secondAttribute == .top
            {
                DefaultLogger.logger.log("V - Bottom - Top");
                cons.constant = srcScreen.scaledHeight( value: cons.constant)
            }
            else if cons.firstAttribute == .width && cons.secondAttribute == .notAnAttribute
            {
                DefaultLogger.logger.log("H - Width");
                cons.constant = srcScreen.scaledWidth( value: cons.constant)
            }
            else if cons.firstAttribute == .leading || cons.secondAttribute == .leading
            {
                DefaultLogger.logger.log("H - Leading");
                cons.constant = srcScreen.scaledWidth( value: cons.constant)
            }
            else if cons.firstAttribute == .trailing || cons.secondAttribute == .trailing
            {
                DefaultLogger.logger.log("H - Trailing");
                cons.constant = srcScreen.scaledWidth( value: cons.constant)
            }
            else if cons.firstAttribute == .leading && cons.secondAttribute == .trailing || cons.firstAttribute == .trailing && cons.secondAttribute == .leading
            {
                DefaultLogger.logger.log("H - Leading - Trailing");
                cons.constant = srcScreen.scaledWidth( value: cons.constant)
            }
            else{
                DefaultLogger.logger.log(cons);
            }
        }
    }
    
}


extension UIImage {

    /// Resizes an image based on a given width.
    open func resize(toWidth w: CGFloat) -> UIImage? {
        return internalResize(toWidth: w)
    }
    
    /// Resizes an image based on a given height.
    open func resize(toHeight h: CGFloat) -> UIImage? {
        return internalResize(toHeight: h)
    }
    
    private func internalResize(toWidth tw: CGFloat = 0, toHeight th: CGFloat = 0) -> UIImage? {
        var w: CGFloat?
        var h: CGFloat?
        
        if 0 < tw {
            h = size.height * tw / size.width
        } else if 0 < th {
            w = size.width * th / size.height
        }
        
        let g: UIImage?
        let t: CGRect = CGRect(x: 0, y: 0, width: w ?? tw, height: h ?? th)
        UIGraphicsBeginImageContextWithOptions(t.size, false, UIScreen.main.scale)
        draw(in: t, blendMode: .normal, alpha: 1)
        g = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return g
    }
}

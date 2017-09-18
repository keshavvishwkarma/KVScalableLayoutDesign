//
//  UIUIView+Extension.swift
//  ScalableLayoutDesign
//
//  Created by Keshav on 7/21/17.
//  Copyright © 2017 Keshav. All rights reserved.
//


#if os(iOS) || os(tvOS)
    
import UIKit

extension UIView {
    public func scaledContent(from srcScreen: Screen = .iPhone6) {
        scaledContent(by: srcScreen.scaledWidth( value: 1))
    }
}

extension UIView {
    // Implemnted by It's subclasses
    @objc public func scaledContent(by ratio: CGFloat) {
        DefaultLogger.logger.log(#function)
    }
}

extension UILabel {
    public override func scaledContent(by ratio: CGFloat) {
        if let scaledAttributedText = attributedText?.scaledContent(by: ratio){
            attributedText = scaledAttributedText
        }else{
            font = font.scaledFont(by: ratio)
        }
    }
}

extension UIButton {
    public override func scaledContent(by ratio: CGFloat) {
        self.titleLabel?.scaledContent(by: ratio)
    }
}

extension UITextField {
    public override func scaledContent(by ratio: CGFloat) {
        if let scaledAttributedText = attributedText?.scaledContent(by: ratio){
            attributedText = scaledAttributedText
        }else{
            font = font?.scaledFont(by: ratio)
        }
    }
}

extension UITextView {
    public override func scaledContent(by ratio: CGFloat) {
        if let scaledAttributedText = attributedText?.scaledContent(by: ratio){
            attributedText = scaledAttributedText
        }else{
            font = font?.scaledFont(by: ratio)
        }
    }
}

extension UISegmentedControl {
    public override func scaledContent(by ratio: CGFloat) {
        
    }
}

extension UIFont {
    fileprivate func scaledFont(by ratio: CGFloat) -> UIFont {
        return UIFont(name: fontName, size: pointSize * ratio)!
    }
}

extension NSAttributedString {
    
    open func scaledContent(from srcScreen: Screen = .iPhone6) -> NSAttributedString {
        return scaledContent(by: srcScreen.scaledWidth( value: 1))
    }
    
    open func scaledContent(by ratio: CGFloat) -> NSAttributedString {
        let mutable = mutableCopy() as! NSMutableAttributedString
        mutable.scaledMutableContent(by: ratio)
        return mutable
    }
    
}

extension NSMutableAttributedString {
    
    open func scaledMutableContent(from srcScreen: Screen = .iPhone6) {
        return scaledMutableContent(by: srcScreen.scaledWidth( value: 1))
    }
    
    open func scaledMutableContent(by ratio: CGFloat) {
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
    
#endif


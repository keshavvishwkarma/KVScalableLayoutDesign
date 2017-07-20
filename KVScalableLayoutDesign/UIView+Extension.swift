//
//  UIView+Extension.swift
//  ScalableLayoutDesign
//
//  Created by Keshav on 7/21/17.
//  Copyright © 2017 Keshav. All rights reserved.
//

import UIKit

extension UIView
{
    func scaledLayoutDesignBasedOn( designedScreen ds:Screen = .iPhone6) {
        self.traceConstraint(baseScreen: ds)

        for v in subviews {
            v.scaledLayoutDesignBasedOn(designedScreen: ds)
        }
    }
    
    private func traceConstraint( baseScreen s:Screen)
    {
        for cons in constraints
        {
            if cons.firstAttribute == .height && cons.secondAttribute == .notAnAttribute
            {
                print("V - Height");
                cons.constant = s.scaledHeight( value: cons.constant)
            }
            else if cons.firstAttribute == .bottom || cons.secondAttribute == .bottom
            {
                print("V - Bottom");
                cons.constant = s.scaledHeight( value: cons.constant)
            }
            else if cons.firstAttribute == .top || cons.secondAttribute == .top
            {
                print("V - Top");
                cons.constant = s.scaledHeight( value: cons.constant)
            }
            else if cons.firstAttribute == .bottom && cons.secondAttribute == .top || cons.firstAttribute == .bottom && cons.secondAttribute == .top
            {
                print("V - Bottom - Top");
                cons.constant = s.scaledHeight( value: cons.constant)
            }
            else if cons.firstAttribute == .width && cons.secondAttribute == .notAnAttribute
            {
                print("H - Width");
                cons.constant = s.scaledWidth( value: cons.constant)
            }
            else if cons.firstAttribute == .leading || cons.secondAttribute == .leading
            {
                print("H - Leading");
                cons.constant = s.scaledWidth( value: cons.constant)
            }
            else if cons.firstAttribute == .trailing || cons.secondAttribute == .trailing
            {
                print("H - Trailing");
                cons.constant = s.scaledWidth( value: cons.constant)
            }
            else if cons.firstAttribute == .leading && cons.secondAttribute == .trailing || cons.firstAttribute == .trailing && cons.secondAttribute == .leading
            {
                print("H - Leading - Trailing");
                cons.constant = s.scaledWidth( value: cons.constant)
            }
            else{
                print(cons);
            }
        }
    }
    
}

//
//  ViewController.swift
//  KVScalableLayoutDesign
//
//  Created by Keshav on 7/21/17.
//  Copyright © 2017 Keshav. All rights reserved.
//

import UIKit
import KVScalableLayoutKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        DefaultLogger.logger.log = !true
        DefaultLogger.logger.log(self.view.subviews.count.description);
        
        self.view.scaledLayoutDesign() // by defualt iPhone6
//        self.view.scaledLayoutDesign(from: .iPhone8)
        
    }

}

extension UISegmentedControl {
    
    open override func scaledContent(by ratio: CGFloat) {
        DefaultLogger.logger.log(#function)
    }
    
}

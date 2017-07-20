//
//  ViewController.swift
//  KVScalableLayoutDesign
//
//  Created by Keshav on 7/21/17.
//  Copyright © 2017 Keshav. All rights reserved.
//

import UIKit
//import KVConstraintKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print(self.view.subviews.count.description);
        
        self.view.scaledLayoutDesignBasedOn(designedScreen: .iPhone6)
        
        //  let button = UIButton.prepareAutoLayoutView()
        //  button.backgroundColor = UIColor.redColor()
        //  view.addSubview(button)
        //
        //  button +== [.CenterX, .CenterY]
        //  button +== (.Width, 280)
        //  button +== (.AspectRatio, 0)
        //
        //  print((button <- .Width)?.constant)
        //  print((button <- .Height)?.constant)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


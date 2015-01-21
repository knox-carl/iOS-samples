//
//  ViewController.swift
//  StrutsProblem
//
//  Created by Carl R Knox on 1/21/15.
//  Copyright (c) 2015 Carl R Knox. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var topRightView: UIView!
    @IBOutlet weak var topLeftView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    override func viewWillLayoutSubviews() {
        
        if UIInterfaceOrientationIsLandscape(self.interfaceOrientation) {
            var rect = self.topLeftView.frame
            rect.size.width = 254
            rect.size.height = 130
            self.topLeftView.frame = rect
            
            rect = self.topRightView.frame
            rect.origin.x = 294
            rect.size.width = 254
            rect.size.height = 130
            self.topRightView.frame = rect
            
            rect = self.bottomView.frame
            rect.origin.y = 170
            rect.size.width = 528
            rect.size.height = 130
            self.bottomView.frame = rect
        } else {
            
            var rect = self.topLeftView.frame
            rect.size.width = 130
            rect.size.height = 254
            self.topLeftView.frame = rect
            
            rect = self.topRightView.frame
            rect.origin.x = 170
            rect.size.width = 130
            rect.size.height = 254
            self.topRightView.frame = rect
            
            rect = self.bottomView.frame
            rect.origin.y = 295
            rect.size.width = 280
            rect.size.height = 254
            self.bottomView.frame = rect
        }
        
    }
    */
}


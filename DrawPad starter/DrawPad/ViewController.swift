//
//  ViewController.swift
//  DrawPad
//
//  Created by Jean-Pierre Distler on 13.11.14.
//  Copyright (c) 2014 Ray Wenderlich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var mainImageView: UIImageView!
  @IBOutlet weak var tempImageView: UIImageView!
    
    // lastPoint stores the last drawn point on the canvas. This is used when a
    // continuous brush stroke is being drawn on the canvas.
    var lastPoint = CGPoint.zeroPoint
    
    // red, green, and blue store the current RGB values of the selected color.
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    
    // brushWidth and opacity store the brush stroke width and opacity.
    var brushWidth: CGFloat = 10.0
    var opacity: CGFloat = 1.0
    
    // swiped identifies if the brush stroke is continuous.
    var swiped = false
    

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
    
    
    let colors: [(CGFloat, CGFloat, CGFloat)] = [
        (0, 0, 0),
        (105.0 / 255.0 , 105.0 / 255.0, 105.0 / 255.0),
        (1.0, 0, 0),
        (0, 0, 1.0),
        (51.0 / 255.0, 204.0 / 255.0, 1.0),
        (102.0 / 255.0, 204.0 / 255.0, 0),
        (102.0 / 255.0, 1.0, 0),
        (160.0 / 255.0, 82.0 / 255.0, 45.0 / 255.0),
        (1.0, 102.0 / 255.0, 0),
        (1.0, 1.0, 0),
        (1.0, 1.0, 1.0),
    ] // end colors
    
    
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        swiped = false
        if let touch = touches.anyObject() as? UITouch {
            lastPoint = touch.locationInView(self.view)
        }
    }
    
    
    func drawLineFrom(fromPoint: CGPoint, toPoint: CGPoint) {
        
        // 1
        // here we draw a line between two points. remember that this app has
        // two image views- mainImageView (which holds the "drawing so far") and
        // tempImageView (which holds the "line you're currently drawing"). Here
        // you want to draw into tempImageView, so you need to set up a drawing 
        // context with the image currently in the tempImageView (which should
        // be empty the first time).
        UIGraphicsBeginImageContext(view.frame.size)
        let context = UIGraphicsGetCurrentContext()
        tempImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width,
            height: view.frame.size.height))
        
        // 2
        // Next, you get the current touch point and then draw a line with 
        // CGContextAddLineToPoint from lastPoint to currentPoint. You might think
        // that this appraoch will produce a series of straight lines and the
        // result will look like a set of jagged lines. This WILL produce straight
        // lines, but the touch events fire so quickly that the lines are short
        // enough and the result will look like a nice smooth curve.
        CGContextMoveToPoint(context, fromPoint.x, toPoint.y)
        CGContextAddLineToPoint(context, toPoint.x, toPoint.y)
        
        // 3
        // here are all the drawing parameters for brush size and opacity and
        // brush stroke color.
        CGContextSetLineCap(context, kCGLineCapSquare)
        CGContextSetLineWidth(context, brushWidth)
        CGContextSetRGBStrokeColor(context, red, green, blue, 1.0)
        CGContextSetBlendMode(context, kCGBlendModeNormal)
        
        // 4
        // this is where the magic happens, and where you actually draw the 
        // path!
        CGContextStrokePath(context)
        
        // 5
        // next, you need to wrap up the drawing context to render the new
        // line into the temporary image view.
        tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        tempImageView.alpha = opacity
        UIGraphicsEndImageContext()
        
        
    } // end drawLineFrom

    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        
        // 6
        // in touchesMoved, you set swiped to true so you can keep track of whether
        // there is a current swipe in progress. since this is touchesMoved, the
        // answer is yes, there is a swipe in progress! You then call the helper
        // method you just wrote to draw the line.
        swiped = true
        if let touch = touches.anyObject() as? UITouch {
            
            let currentPoint = touch.locationInView(view)
            drawLineFrom(lastPoint, toPoint: currentPoint)
            
            // 7
            // finally, you update the lastPoint so the next touch event will
            // continue where you just left off.
            lastPoint = currentPoint
            
        } // end if
        
    } // end touchesMoved
    
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        if !swiped {
            // draw a single point
            drawLineFrom(lastPoint, toPoint: lastPoint)
        }
        
        // Merge tempImageView into mainImageView
        UIGraphicsBeginImageContext(mainImageView.frame.size)
        mainImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width,
            height: view.frame.size.height), blendMode:kCGBlendModeNormal, alpha: 1.0)
        tempImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width,
            height: view.frame.size.height), blendMode: kCGBlendModeNormal, alpha: opacity)
        mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        tempImageView.image = nil
        
        
    } // end touchesEnded
    

  // MARK: - Actions

  @IBAction func reset(sender: AnyObject) {
    
    mainImageView.image = nil
    
  }

  @IBAction func share(sender: AnyObject) {
    
    UIGraphicsBeginImageContext(mainImageView.bounds.size)
    mainImageView.image?.drawInRect(CGRect(x: 0, y: 0,
        width: mainImageView.frame.size.width, height: mainImageView.frame.size.height))
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    let activity = UIActivityViewController(activityItems: [image], applicationActivities: nil)
    presentViewController(activity, animated: true, completion: nil)
    
  }
  
  @IBAction func pencilPressed(sender: AnyObject) {
    
    // 1
    // first, you need to know which color index the user selected. there are
    // many places this could go wrong - incorrect tag, tag not set, not enough
    // colors in the array - so there are a few checks here. the default if the
    // value is out of range is just black, the first color.
    var index = sender.tag ?? 0
    if index < 0 || index >= colors.count {
        index = 0
    }
    
    // 2
    // next, you set the red, green, and blue properties. you didn't know you could set
    // multiple variables with a tuple like that? there's your swift tip of the day! :]
    (red, green, blue) = colors[index]
    
    // 3
    // the last color is the eraser, so it's a bit special. the eraser button sets the
    // color to white and opacity to 1.0. as your background color is also white, this will
    // give you a very handy eraser effect.
    if index == colors.count - 1 {
        
        opacity = 1.0
        
    }
    
  } // end pencilPressed
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let settingsViewController = segue.destinationViewController as
        SettingsViewController
            settingsViewController.delegate = self
            settingsViewController.brush = brushWidth
            settingsViewController.opacity = opacity
            settingsViewController.red = red
            settingsViewController.green = green
            settingsViewController.blue = blue
    }
    
}

extension ViewController: SettingsViewControllerDelegate {
    
    func settingsViewControllerFinished(settingsViewController: SettingsViewController) {
        self.brushWidth = settingsViewController.brush
        self.opacity = settingsViewController.opacity
        self.red = settingsViewController.red
        self.green = settingsViewController.green
        self.blue = settingsViewController.blue
    }
    
}


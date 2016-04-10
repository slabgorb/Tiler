//
//  ExpandSegue.swift
//  Tiler
//
//  Created by Keith Avery on 4/10/16.
//  Copyright © 2016 Keith Avery. All rights reserved.
//

import UIKit

class ExpandSegue: UIStoryboardSegue {
    override func perform() {
        let firstVCView = self.sourceViewController.view as UIView!
        let secondVCView = self.destinationViewController.view as UIView!
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        let screenHeight = UIScreen.mainScreen().bounds.size.height
        secondVCView.frame = CGRectMake(0.0, screenHeight, screenWidth, screenHeight)
        let window = UIApplication.sharedApplication().keyWindow
        window?.insertSubview(secondVCView, aboveSubview: firstVCView)
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            firstVCView.frame = CGRectOffset(firstVCView.frame, 0.0, -screenHeight)
            secondVCView.frame = CGRectOffset(secondVCView.frame, 0.0, -screenHeight)
        }) { (finished) -> Void in
            self.sourceViewController.presentViewController(self.destinationViewController as UIViewController,                                                            animated: false,                                                            completion: nil)
        }
    }
}


class UnwindExpandSegue: UIStoryboardSegue {
    override func perform() {
        let secondVCView = self.sourceViewController.view as UIView!
        let firstVCView = self.destinationViewController.view as UIView!
        let screenHeight = UIScreen.mainScreen().bounds.size.height
        
        let window = UIApplication.sharedApplication().keyWindow
        window?.insertSubview(firstVCView, aboveSubview: secondVCView)
        
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            firstVCView.frame = CGRectOffset(firstVCView.frame, 0.0, screenHeight)
            secondVCView.frame = CGRectOffset(secondVCView.frame, 0.0, screenHeight)
        }) { (Finished) -> Void in
            self.sourceViewController.dismissViewControllerAnimated(false, completion: nil)
        }
    }
}
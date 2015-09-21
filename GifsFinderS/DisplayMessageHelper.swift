//
//  DisplayMessageHelper.swift
//  GifsFinderS
//
//  Created by Johnson Liu on 9/19/15.
//  Copyright (c) 2015 HomeOffice. All rights reserved.
//

import UIKit

class DisplayMessageHelper: NSObject {
    
    class func alertMessage(viewController: UIViewController, alertTitle: String, alertBody: String) {
        
        var alert = UIAlertController(title:alertTitle, message:alertBody, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        viewController.presentViewController(alert, animated: true, completion: nil)
    }
    
}

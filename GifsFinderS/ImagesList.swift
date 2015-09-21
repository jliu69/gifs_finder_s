//
//  ImagesList.swift
//  GifsFinderS
//
//  Created by Johnson Liu on 9/17/15.
//  Copyright (c) 2015 HomeOffice. All rights reserved.
//

import UIKit

class ImagesList: NSObject {
    
    func imageData() -> [AnyObject] {
        
        var gifSize:CGSize = CGSizeMake(60, 60)
        
        var item1: ImageModel = ImageModel()
        item1.gifImage = self.getImageWithColor(UIColor.redColor(), size: gifSize)
        item1.gifDesc = "Image 1, Red"
        
        var item2: ImageModel = ImageModel()
        item2.gifImage = self.getImageWithColor(UIColor.greenColor(), size: gifSize)
        item2.gifDesc = "Image 2, Green"
        
        var item3: ImageModel = ImageModel()
        item3.gifImage = self.getImageWithColor(UIColor.blueColor(), size: gifSize)
        item3.gifDesc = "Image 3, Blue"
        
        var item4: ImageModel = ImageModel()
        item3.gifImage = self.getImageWithColor(UIColor.lightGrayColor(), size: gifSize)
        item3.gifDesc = "Image 4, Light Gray"
        
        var imagesList:  [AnyObject] = []
        imagesList = [item1, item2, item3, item4]
        
        return imagesList
    }
    
    func getImageWithColor(color: UIColor, size: CGSize) -> UIImage {
        
        let rect = CGRectMake(0, 0, size.width, size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
}

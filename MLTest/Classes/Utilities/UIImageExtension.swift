//
//  UIImageExtension.swift
//  MLTest
//
//  Created by Robert Bevilacqua on 3/15/18.
//  Copyright © 2018 Robert Bevilacqua. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    class func imageFromColor(color: UIColor) -> UIImage {
        return imageFromColor(color: color, size: CGSize(width: 10, height: 10))
        
    }
    
    class func imageFromColor(color: UIColor, size: CGSize) -> UIImage {
        let imageView = UIView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        imageView.backgroundColor = color
        return imageView.convertToImage()
    }
    
    func rotate(radians: Float) -> UIImage? {
        var newSize = CGRect(origin: CGPoint.zero, size: self.size).applying(CGAffineTransform(rotationAngle: CGFloat(radians))).size
        // Trim off the extremely small float value to prevent core graphics from rounding it up
        newSize.width = floor(newSize.width)
        newSize.height = floor(newSize.height)
        
        UIGraphicsBeginImageContext(newSize);
        let context = UIGraphicsGetCurrentContext()!
        
        // Move origin to middle
        context.translateBy(x: newSize.width/2, y: newSize.height/2)
        // Rotate around middle
        context.rotate(by: CGFloat(radians))
        
        self.draw(in: CGRect(x: -self.size.width/2, y: -self.size.height/2, width: self.size.width, height: self.size.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
}

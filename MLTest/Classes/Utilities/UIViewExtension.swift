//
//  UIViewExtension.swift
//  MLTest
//
//  Created by Robert Bevilacqua on 3/15/18.
//  Copyright © 2018 Robert Bevilacqua. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        
        
        var caLayerColor: CALayer?
        _ = self.layer.sublayers?.filter({ (item) -> Bool in
            if item.classForCoder === CALayer.self {
                caLayerColor = item
                return true
            } else {
                return false
            }
        })
        
        
        
        UIView.animate(withDuration: 0.4, animations: {
            caLayerColor?.borderColor = UIColor.red.cgColor
        }) { (status) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                
                UIView.animate(withDuration: 0.4, animations: {
                    caLayerColor?.borderColor = UIColor.lightGray.cgColor
                    
                })
            }
        }
        
        layer.add(animation, forKey: "shake")
    }
    
    func convertToImage() -> UIImage {
        UIGraphicsBeginImageContext(self.bounds.size);
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let viewImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return viewImage!
    }
    
}

//extension UIColor {
//
//    public func contrastColor() -> UIColor {
//        var d = CGFloat(0)
//
//        var r = CGFloat(0)
//        var g = CGFloat(0)
//        var b = CGFloat(0)
//        var a = CGFloat(0)
//
//        self.getRed(&r, green: &g, blue: &b, alpha: &a)
//
//        // Counting the perceptive luminance - human eye favors green color...
//        let luminance = 1 - ((0.299 * r) + (0.587 * g) + (0.114 * b))
//
//        if luminance < 0.5 {
//            d = CGFloat(0) // bright colors - black font
//        } else {
//            d = CGFloat(1) // dark colors - white font
//        }
//
//        return UIColor( red: d, green: d, blue: d, alpha: a)
//    }
//
//}


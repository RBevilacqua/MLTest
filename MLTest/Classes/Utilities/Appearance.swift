//
//  Appearance.swift
//  MLTest
//
//  Created by Robert Bevilacqua on 3/15/18.
//  Copyright © 2018 Robert Bevilacqua. All rights reserved.
//

import UIKit

let screenSize = UIScreen.main.bounds
let screenWidth = screenSize.width
let screenHeight = screenSize.height

class Appearance: NSObject {
    
    class func transparentNavigationBar(navigationBar: UINavigationBar?){
        navigationBar?.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar?.shadowImage = UIImage()
    }
    
    class func colorNavigationBar(navigationBar: UINavigationBar?, color: UIColor){
        navigationBar?.setBackgroundImage(UIImage.imageFromColor(color: color), for: UIBarMetrics.default)
        navigationBar?.barTintColor = UIColor.white
        navigationBar?.shadowImage = UIImage()
    }
    
}

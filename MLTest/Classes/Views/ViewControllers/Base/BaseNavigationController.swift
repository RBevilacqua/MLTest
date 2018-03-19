//
//  BaseNavigationController.swift
//  MLTest
//
//  Created by Robert Bevilacqua on 3/15/18.
//  Copyright © 2018 Robert Bevilacqua. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.configNavigation()
        
    }
    
    
    func configNavigation() -> Void {
        
        self.navigationBar.barTintColor = .white
        self.navigationBar.tintColor = .white
        
        self.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        UIApplication.shared.statusBarStyle = .lightContent
        self.navigationBar.isTranslucent = true
        Appearance.colorNavigationBar(navigationBar: self.navigationBar, color: UIColor(red: 33/255, green: 191/255, blue: 233/255, alpha: 1.0))
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

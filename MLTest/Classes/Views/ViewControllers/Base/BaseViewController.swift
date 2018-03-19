//
//  BaseViewController.swift
//  MLTest
//
//  Created by Robert Bevilacqua on 3/18/18.
//  Copyright © 2018 Robert Bevilacqua. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var loading: Loading?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configBackButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func configBackButton() -> Void {
        
        if let count = navigationController?.viewControllers.count {
            if count > 1 && navigationItem.leftBarButtonItem == nil {
                if  !(navigationController?.viewControllers.first === self) {
                    let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backImage"), style: .plain, target: self, action: #selector(self.backAction))
                    self.navigationItem.leftBarButtonItem = leftBarButtonItem
                    self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
                } else {
                }
            }
        }
        
    }
    
    func configTitle(name: String) -> Void {
        self.title = name
    }
    
    @objc func backAction() -> Void {
        self.navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "changeOrientation"), object: nil)
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

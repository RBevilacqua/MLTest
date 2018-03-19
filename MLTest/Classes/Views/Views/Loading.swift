//
//  Loading.swift
//  MLTest
//
//  Created by Robert on 3/18/18.
//  Copyright © 2018 Robert Bevilacqua. All rights reserved.
//

import UIKit

class Loading: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentLoading: UIView!
    @IBOutlet weak var iconLoading: UIView!
    @IBOutlet weak var titleLabelLoading: UILabel!
    
    init() {
        super.init(frame: CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: screenSize.height))
        self.loadViewFromNib(nibName: "Loading")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func configureMessage() -> Void {
        self.contentLoading.layer.cornerRadius = 8
    }
    
    private func loadViewFromNib(nibName: String) {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! Loading
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
        
    }
    
    func show(timer: TimeInterval? = 2.0) -> Void {
        self.configureMessage()
        
        UIApplication.shared.keyWindow?.addSubview(self)
        
        UIView.animate(withDuration: 0.2, animations: {
            self.frame.origin.y = 0
            self.contentView.alpha = 0.5
            self.contentLoading.alpha = 1
            
        }) { (status) in
        }
    }
    
    func dismiss() -> Void {
        
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            self?.contentLoading.alpha = 0
            self?.contentView.alpha = 0
        }, completion: { [weak self] (status) in
            UIView.animate(withDuration: 0.8, animations: { [weak self] in
                self?.frame.origin.y = screenSize.height
            }, completion: { [weak self] (status) in
                self?.removeFromSuperview()
            })
        })
        
    }
    
}

//
//  Message.swift
//  MLTest
//
//  Created by Robert on 3/18/18.
//  Copyright © 2018 Robert Bevilacqua. All rights reserved.
//

import UIKit

enum MessageType {
    case warning
    case success
}

class Message: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    
    private init() {
        super.init(frame: CGRect(x: 0, y: -60, width: screenSize.width, height: 72))
        self.loadViewFromNib(nibName: "Message")
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configureMessage(type: MessageType) -> Void {
        let image: UIImage?
        if type == .success {
            image = UIImage(named: "ic_warning")?.withRenderingMode(.alwaysTemplate)
            self.iconImageView.tintColor = UIColor(red: 75/255, green: 181/255, blue: 67/255, alpha: 1.0)
            self.contentView.backgroundColor = UIColor(red: 55/255, green: 55/255, blue: 55/255, alpha: 1.0)
            
        } else {
            image = UIImage(named: "ic_check")?.withRenderingMode(.alwaysTemplate)
            self.iconImageView.tintColor = UIColor(red: 255/255, green: 204/255, blue: 0/255, alpha: 1.0)
            self.contentView.backgroundColor = UIColor(red: 65/255, green: 65/255, blue: 65/255, alpha: 1.0)
            
        }
        self.iconImageView.contentMode = .scaleAspectFit
        self.iconImageView.image = image
    }
    
    func loadViewFromNib(nibName: String) {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! Message
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
        
    }
    
    class func show(text: String, timer: TimeInterval? = 2.0, type: MessageType, completion: (() -> Swift.Void)? = nil) -> Void {
        var message: Message? = Message()
        message?.titleLabel.text = text
        message?.configureMessage(type: type)
        
        UIApplication.shared.keyWindow?.addSubview(message!)
        
        UIView.animate(withDuration: 0.8, animations: {
            message?.frame.origin.y = 0
        }) { (status) in
            UIView.animate(withDuration: 0.8, delay: timer!, options: .allowAnimatedContent, animations: {
                message?.frame.origin.y = -60
            }, completion: { (status) in
                message?.removeFromSuperview()
                message = nil
                if completion != nil {
                    completion!()
                }
                
            })
        }
    }

}

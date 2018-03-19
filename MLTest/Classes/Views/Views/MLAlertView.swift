//
//  MLAlertView.swift
//  MLTest
//
//  Created by Robert Bevilacqua on 3/18/18.
//  Copyright © 2018 Robert Bevilacqua. All rights reserved.
//

import UIKit
import Kingfisher

class MLAlertView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var paymentMethodContentView: UIView!
    @IBOutlet weak var issuerContentView: UIView!
    @IBOutlet weak var installmentContentView: UIView!
    
    @IBOutlet weak var acceptButton: UIButton!
    
    @IBOutlet weak var paymentImage: UIImageView!
    @IBOutlet weak var paymentTitleLabel: UILabel!
    
    @IBOutlet weak var issuerImage: UIImageView!
    @IBOutlet weak var issuerTitleLabel: UILabel!

    @IBOutlet weak var installmentTitleLabel: UILabel!
    
    @IBOutlet weak var totalAmountLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init() {
        super.init(frame: CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: screenSize.height))
        self.loadViewFromNib(nibName: "MLAlertView")
        defer {
            self.configureScreen()
        }
    }
    
    init(frame: CGRect, loadString: String? = "MLAlertView") {
        super.init(frame: frame)
        self.loadViewFromNib(nibName: loadString ?? "")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configureScreen() -> Void  {
        self.contentView.alpha = 0
        self.contentView.layer.cornerRadius = 4.0
        
        self.paymentMethodContentView.layer.cornerRadius = 4.0
        self.configureShadow(view: self.paymentMethodContentView)
        
        self.issuerContentView.layer.cornerRadius = 4.0
        self.configureShadow(view: self.issuerContentView)
        
        self.installmentContentView.layer.cornerRadius = 4.0
        self.configureShadow(view: self.installmentContentView)
    }
    
    func setData(payment: PaymentMethods, issuer: IssuerCard, payer: PayerCost, amount: Float) -> Void {
        
        self.paymentTitleLabel.text = payment.name ?? ""
        self.issuerTitleLabel.text = issuer.name ?? ""
        self.installmentTitleLabel.text = payer.recommended_message ?? ""
        
        guard let paymentImg = payment.secureThumbnail else {
            self.paymentImage.image = UIImage(named: "")
            return
        }
        guard let issuerImg = issuer.secureThumbnail else {
            self.paymentImage.image = UIImage(named: "")
            return
        }
        
        self.setImage(image: paymentImg, imageView: paymentImage)
        self.setImage(image: issuerImg, imageView: issuerImage)
        
        self.totalAmountLabel.text = "Total $ \(amount)"
        
    }
    
    private func setImage(image: String, imageView: UIImageView) -> Void {
        
        imageView.kf.indicatorType = .activity
        imageView.kf.indicator!.startAnimatingView()
        imageView.kf.setImage(with: URL(string: image) as Resource?,
                                   placeholder: UIImage(named: ""),
                                   options: [.transition(ImageTransition.fade(1))],
                                   progressBlock: { receivedSize, totalSize in
                                    print("\(receivedSize)/\(totalSize)")
        },
                                   completionHandler: { image, error, cacheType, imageURL in
                                    print("Finished")
                                    imageView.kf.indicator!.stopAnimatingView()
        })
    }
    
    func configureShadow(view: UIView) -> Void {
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.7
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 2.0
    }
    
    func loadViewFromNib(nibName: String) {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! MLAlertView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
    }
    
    func show(timer: TimeInterval? = 0.8) -> Void {
        
        UIApplication.shared.keyWindow?.addSubview(self)
        
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            self?.frame.origin.y = 0
            
            
        }) { (status) in
            UIView.animate(withDuration: timer!, animations: { [weak self] in
                self?.contentView.alpha = 1
                self?.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            })
        }
    }
    
    func dismiss() -> Void {
        
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            self?.contentView.alpha = 0
            self?.backgroundColor = UIColor.clear
            }, completion: { [weak self] (status) in
                UIView.animate(withDuration: 0.8, animations: { [weak self] in
                    self?.frame.origin.y = screenSize.height
                    }, completion: { [weak self] (status) in
                        self?.removeFromSuperview()
                })
        })
        
    }
    
    
    @IBAction func acceptAction(_ sender: UIButton) {
        self.dismiss()
    }
    
}

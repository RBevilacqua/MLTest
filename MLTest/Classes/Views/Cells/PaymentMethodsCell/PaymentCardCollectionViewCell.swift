//
//  PaymentCardCollectionViewCell.swift
//  MLTest
//
//  Created by Robert Bevilacqua on 3/15/18.
//  Copyright © 2018 Robert Bevilacqua. All rights reserved.
//

import UIKit
import Kingfisher

class PaymentCardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageArrow: UIImageView!
    
    var payment: PaymentMethods?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupView(data: PaymentMethods) -> Void {
        
        let image = UIImage(named: "arrow")!
        let newImage = image.rotate(radians: .pi)
        
        self.imageArrow.image = newImage
        
        self.nameLabel.text = data.name
        
        if data.secureThumbnail != nil {
            self.cardImage.kf.indicatorType = .activity
            self.cardImage.kf.indicator!.startAnimatingView()
            self.cardImage.kf.setImage(with: URL(string: data.secureThumbnail != nil ? data.secureThumbnail! : "") as Resource?,
                                       placeholder: UIImage(named: ""),
                                       options: [.transition(ImageTransition.fade(1))],
                                       progressBlock: { receivedSize, totalSize in
                                        print("\(receivedSize)/\(totalSize)")
            },
                                       completionHandler: { image, error, cacheType, imageURL in
                                        print("Finished")
                                        self.cardImage.kf.indicator!.stopAnimatingView()
            })
            
        } else {
            self.cardImage.image = UIImage(named: "")
        }
        
    }

}

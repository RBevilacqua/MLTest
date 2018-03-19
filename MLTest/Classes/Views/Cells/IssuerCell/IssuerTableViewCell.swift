//
//  IssuerTableViewCell.swift
//  MLTest
//
//  Created by Robert Bevilacqua on 3/17/18.
//  Copyright © 2018 Robert Bevilacqua. All rights reserved.
//

import UIKit
import Kingfisher

class IssuerTableViewCell: UITableViewCell {

    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var arrowView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configIssuerCell(data: IssuerCard) -> Void {
        
        self.titleLabel.text = data.name
        
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

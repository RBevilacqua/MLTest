//
//  InstallmentTableViewCell.swift
//  MLTest
//
//  Created by Robert Bevilacqua on 3/17/18.
//  Copyright © 2018 Robert Bevilacqua. All rights reserved.
//

import UIKit
import Kingfisher

class InstallmentTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var quotaLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configIssuerCell(data: PayerCost) -> Void {
        
        self.titleLabel.text = data.recommended_message
        if let installAmount = data.installment_amount {
            self.quotaLabel.text = "$ \(installAmount)"
        } else {
            self.quotaLabel.text = ""
        }
        
        
    }
    
}

//
//  IssuerCard.swift
//  MLTest
//
//  Created by Robert Bevilacqua on 3/13/18.
//  Copyright © 2018 Robert Bevilacqua. All rights reserved.
//

import Foundation
import UIKit

class IssuerCard: NSObject, Codable {
    
    var id: String?
    var name: String?
    var processingMode: String?
    var thumbnail: String?
    var secureThumbnail: String?
    var merchantAccountId: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case processingMode = "processing_mode"
        case thumbnail
        case merchantAccountId = "merchant_account_id"
        case secureThumbnail = "secure_thumbnail"
    }
    
}

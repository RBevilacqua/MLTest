//
//  PaymentMethods.swift
//  MLTest
//
//  Created by Robert Bevilacqua on 3/13/18.
//  Copyright © 2018 Robert Bevilacqua. All rights reserved.
//

import UIKit

class PaymentMethods: NSObject, Codable {
    
    var id: String?
    var name: String?
    var paymentTypeId: String?
    var thumbnail: String?
    var secureThumbnail: String?
    var status: Status? = .active
    var progresingModes: [String]?
    
    var minAllowedAmount: Float?
    var maxAllowedAmount: Float?
    var accreditationTime: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case paymentTypeId = "payment_type_id"
        case thumbnail = "thumbnail"
        case secureThumbnail = "secure_thumbnail"
        case status
        case progresingModes = "processing_modes"
        case minAllowedAmount = "min_allowed_amount"
        case maxAllowedAmount = "max_allowed_amount"
        case accreditationTime = "accreditation_time"
        
    }
    
}


enum Status: String, Codable {
    case active = "active"
    case inactive = "inactive"
}

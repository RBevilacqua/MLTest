//
//  Installments.swift
//  MLTest
//
//  Created by Robert Bevilacqua on 3/13/18.
//  Copyright © 2018 Robert Bevilacqua. All rights reserved.
//

import Foundation

class Installments: NSObject, Codable {
    
    var paymentMethodId: String?
    var paymentTypeId: String?
    var issuer: IssuerCard?
    var processingMode: String?
    var merchantAccountId: String?
    
    var payerCosts: [PayerCost]?
    
    enum CodingKeys: String, CodingKey {
        case paymentMethodId = "payment_method_id"
        case paymentTypeId = "payment_type_id"
        case issuer
        case processingMode = "processing_mode"
        case merchantAccountId = "merchant_account_id"
        
        case payerCosts = "payer_costs"
    }
    
}

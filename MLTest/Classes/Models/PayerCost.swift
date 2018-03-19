//
//  PayerCost.swift
//  MLTest
//
//  Created by Robert Bevilacqua on 3/13/18.
//  Copyright © 2018 Robert Bevilacqua. All rights reserved.
//

import Foundation

class PayerCost: NSObject, Codable {
    
    var installments: Float?
    var installment_rate: Float?
    var discount_rate: Float?
    var installment_rate_collector: [String]?
    var min_allowed_amount: Float?
    var max_allowed_amount: Float?
    var recommended_message: String?
    var installment_amount: Float?
    var total_amount: Float?
    var labels: [String]?
    
}

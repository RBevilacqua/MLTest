//
//  Protocols.swift
//  MLTest
//
//  Created by Robert Bevilacqua on 3/18/18.
//  Copyright © 2018 Robert Bevilacqua. All rights reserved.
//

import Foundation

protocol InstallmentDelegate: NSObjectProtocol {
    func retrievePayCost(payer: PayerCost)
}

protocol IssuerDelegate: NSObjectProtocol {
    func retrieveIssuer(retrieve: (issuer: IssuerCard, payer: PayerCost))
}

protocol PaymentDelegate: NSObjectProtocol {
    func retrievePayment(retrieve: (issuer: IssuerCard, payer: PayerCost, payment: PaymentMethods))
}

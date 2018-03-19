//
//  InstallmentViewModel.swift
//  MLTest
//
//  Created by Robert Bevilacqua on 3/17/18.
//  Copyright © 2018 Robert Bevilacqua. All rights reserved.
//

import UIKit

class InstallmentViewModel: NSObject {
    
    var installment: [Installments] = []
    
    func getInstallment(paymentId: String, issuerId: String, amount: Float, callback: @escaping (_ data: [Installments]?, _ response: URLResponse?, _ error: Error?) -> Void) -> Void {
        
        let params: [String: Any] = [
            "public_key": ServicesManager.params["public_key"]!,
            "payment_method_id": paymentId,
            "issuer.id": issuerId,
            "amount": amount
        ]
        
        ServicesManager.requestJSON(endpointName: "installments", method: .get, params: params, headers: nil) { [weak self] (data) in
            
            if data.error != nil {
                callback(nil, data.response, data.error)
                
            } else {
                do {
                    //Decode retrived data with JSONDecoder and assing type of Article object
                    let dataCoder = try JSONDecoder().decode([Installments].self, from: data.data!)
                    
                    //Get back to the main queue
                    self?.installment = dataCoder
                    callback(dataCoder, data.response, nil)
                    
                } catch let jsonError {
                    print(jsonError)
                    callback(nil, data.response, jsonError)
                }
                
            }
            
        }
        
    }

}

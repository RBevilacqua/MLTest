//
//  PaymentMethodsViewModel.swift
//  MLTest
//
//  Created by Robert Bevilacqua on 3/16/18.
//  Copyright © 2018 Robert Bevilacqua. All rights reserved.
//

import UIKit

class PaymentMethodsViewModel: NSObject {
    
    var paymentMethods: [PaymentMethods] = []
    
    func getPaymentMethods(callback: @escaping (_ data: [PaymentMethods]?, _ response: URLResponse?, _ error: Error?) -> Void) -> Void {
        
        ServicesManager.requestJSON(endpointName: "", method: .get, params: ServicesManager.params, headers: nil) { [weak self] (data) in
            
            if data.error != nil {
                callback(nil, data.response, data.error)
                
            } else {
                do {
                    
                    //Decode retrived data with JSONDecoder and assing type of Article object
                    let dataCoder = try JSONDecoder().decode([PaymentMethods].self, from: data.data!)
                    
                    //Get back to the main queue
                    self?.paymentMethods = dataCoder
                    callback(dataCoder, data.response, nil)
                    
                } catch let jsonError {
                    print(jsonError)
                    callback(nil, data.response, jsonError)
                }
                
            }
            
        }
        
    }

}

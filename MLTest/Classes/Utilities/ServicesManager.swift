//
//  ServicesManager.swift
//  MLTest
//
//  Created by Robert Bevilacqua on 3/16/18.
//  Copyright © 2018 Robert Bevilacqua. All rights reserved.
//

import UIKit
import Alamofire

class ServicesManager: NSObject {
    
    static var baseURL: String = "https://api.mercadopago.com/v1/payment_methods"
    
    static var params: [String: Any] = [
        "public_key": "444a9ef5‐8a6b‐429f‐abdf‐587639155d88"
    ]
    
    class func requestJSON(endpointName: String, method: HTTPMethod, params: [String : Any]? = nil, headers: [String : String]? = nil, callback: @escaping (DataResponse<Any>) -> Void) {
        
        Alamofire.request(URL(string: "\(baseURL)/\(endpointName)")!, method: method, parameters: params, encoding: URLEncoding.default, headers: headers)
            .responseJSON { (response: DataResponse<Any>) in
                callback(response)
        }
    }
    

}

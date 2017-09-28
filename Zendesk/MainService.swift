//
//  MainService.swift
//  Zendesk
//
//  Created by andrei on 9/28/17.
//  Copyright © 2017 andrei. All rights reserved.
//

import Foundation
import Alamofire
import ReactiveSwift
import ReactiveAlamofire



fileprivate let username = "acooke+techtest@zendesk.com"
fileprivate let password = "mobile"

class MainService{
    
    
    public static func get(url:String) -> SignalProducer<Any, GeneralError>
    {
        let callSignalProducer = Alamofire.request(url)
            .authenticate(user: username, password: password)
            .responseProducer()
            .flatMapError { (resultError) -> SignalProducer<ResponseProducerResult, GeneralError> in
                return SignalProducer(error: GeneralError.web(WebErrors.AlamoError));
            }.flatMap(.latest) { (value) -> SignalProducer<Any,GeneralError> in

                guard let d = value.data,let json = try? JSONSerialization.jsonObject(with: d, options: []) else
                {
                    let convertError = ConvertToValueObjectsError.failToConvert(message: "can't extract json from response")
                    return SignalProducer(error: GeneralError.convert(convertError));
                }
                return SignalProducer(value:json)
        }
        
        return callSignalProducer;
        
    }
}

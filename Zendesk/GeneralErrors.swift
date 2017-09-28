//
//  WebErrors.swift
//  Zendesk
//
//  Created by andrei on 9/28/17.
//  Copyright © 2017 andrei. All rights reserved.
//

import Foundation

enum WebErrors : Error
{
    case AlamoError
}

enum ConvertToValueObjectsError : Error
{
    case failToConvert(message:String)
}

enum GeneralError : Error
{
    case empty
    case web(WebErrors)
    case convert(ConvertToValueObjectsError)
}

//
//  HelperServices.swift
//  Zendesk
//
//  Created by andrei on 9/28/17.
//  Copyright © 2017 andrei. All rights reserved.
//

import Foundation
import ReactiveSwift
import ReactiveCocoa
import Result

fileprivate let tiketsURL = "https://mxtechtest.zendesk.com/api/v2/views/39551161/tickets.json"



class HelperServices
{
    public static func getTickesListSignal() -> SignalProducer<TicketsList, GeneralError>
    {
        
        let signal = MainService.get(url: tiketsURL).flatMap(.latest) { (response) -> SignalProducer<TicketsList, GeneralError> in
            
            do
            {
                let ticketsList = try TicketsList(response);
                return SignalProducer(value:ticketsList)
            }catch let error as ConvertToValueObjectsError
            {
                return SignalProducer(error:GeneralError.convert(error))
            }catch {
                return SignalProducer(error:GeneralError.empty)
            }
  
        }
        
        return signal;
        
    }
}

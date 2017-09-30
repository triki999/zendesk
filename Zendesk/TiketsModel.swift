//
//  TiketsModel.swift
//  Zendesk
//
//  Created by andrei on 9/29/17.
//  Copyright © 2017 andrei. All rights reserved.
//

import Foundation
import ReactiveSwift
import ReactiveCocoa

class TicketsModel
{
    let  token = Lifetime.Token()
    var lifeTime:Lifetime
    {
        return Lifetime(token)
    }
    
    private init(){
        getTickets().start()
    }
    
    
    static let instance = TicketsModel()
    
    private var ticketList:TicketsList?
    

    func getTickets() -> SignalProducer<TicketsList,GeneralError>
    {
        if let _ticketList = ticketList{
            return SignalProducer(value:_ticketList);
        }
        
        let signal = HelperServices.getTickesListSignal()
            .take(during: lifeTime)
            .doNext {[weak self] (tickets) in
                self?.ticketList = tickets
            }
        return signal;
    }
    
    func clear()
    {
        ticketList = nil;
    }
    
}

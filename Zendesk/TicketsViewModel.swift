//
//  TicketsViewModel.swift
//  Zendesk
//
//  Created by andrei on 9/29/17.
//  Copyright © 2017 andrei. All rights reserved.
//

import Foundation



import Foundation
import ReactiveSwift
import ReactiveCocoa

class TicketsViewModel
{
    let  token = Lifetime.Token()
    var lifeTime:Lifetime
    {
        return Lifetime(token)
    }
    
    let model = TicketsModel.instance
    
    private var ticketList:TicketsList?

    public func getTickets() -> SignalProducer<TicketsList,GeneralError>
    {
        let signal = model.getTickets()
            .take(during: lifeTime)
            .doNext {[weak self] (list) in
             self?.ticketList = list
        }.observe(on: UIScheduler())
        return signal;
    }
    
    
    var numberOfCells:Int? {
        return ticketList?.tickets.count
    }
    
    func ticketAtIndex(index:Int) -> Ticket?
    {
        return ticketList?.tickets[index]
    }
    
    func clear()
    {
        ticketList = nil;
        model.clear()
    }
    
}

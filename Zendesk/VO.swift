//
//  VO.swift
//  Zendesk
//
//  Created by andrei on 9/28/17.
//  Copyright © 2017 andrei. All rights reserved.
//

import Foundation






struct TicketsList
{
    let tickets:[Ticket]

    init(_ anyData:Any) throws
    {
        guard let json = anyData as? [String:Any],let ticketsList = json["tickets"] as? [Any] else {
            throw ConvertToValueObjectsError.failToConvert(message: "fail to extract TicketsList")
        }
        tickets = try TicketsList.createTickets(tickets: ticketsList)
       
    }
    

    private static func createTickets(tickets:[Any]) throws -> [Ticket]
    {
        
        let result = try tickets.map { (obj) -> Ticket in
            let returnTicket = try Ticket(obj)
            return returnTicket
        }
        return result
    }
    
}

struct Ticket
{
    
    let subject:String;
    let description:String;
    let id:Int;
    let status:String;
    
    init(_ anyData:Any) throws
    {
        guard
            let dictionary = anyData as? [String:Any],
            let subject = dictionary["subject"] as? String,
            let description = dictionary["description"] as? String,
            let id = dictionary["id"] as? Int,
            let status = dictionary["status"] as? String
        else {
                throw ConvertToValueObjectsError.failToConvert(message: "fail to extract Ticket")
                
        }
        
        self.subject = subject;
        self.description = description
        self.id = id;
        self.status = status
    }
}

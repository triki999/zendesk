//
//  TicketCell.swift
//  Zendesk
//
//  Created by andrei on 9/29/17.
//  Copyright © 2017 andrei. All rights reserved.
//

import UIKit

class TicketCell: UITableViewCell {

    @IBOutlet weak var lbSubject: UILabel!
    @IBOutlet weak var lbId: UILabel!
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private var _data:Ticket?
    
    var data:Ticket?
    {
        get{
            return _data
        }
        
        set{
           
            guard let __data = newValue else {
                return;
            }
            
            _data = __data
            
            lbSubject.text = __data.subject;
            lbId.text = "\(__data.id)";
            lbStatus.text = __data.status;
            lbDescription.text = __data.description;
            
        }
    }

}

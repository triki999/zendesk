//
//  ViewController.swift
//  Zendesk
//
//  Created by andrei on 9/28/17.
//  Copyright © 2017 andrei. All rights reserved.
//

import UIKit

class TicketsListController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        HelperServices.getTickesListSignal().doNext { (tickets) in
            print(tickets)
        }.start()
        
       

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


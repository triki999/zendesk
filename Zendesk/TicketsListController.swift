//
//  ViewController.swift
//  Zendesk
//
//  Created by andrei on 9/28/17.
//  Copyright © 2017 andrei. All rights reserved.
//

import UIKit

class TicketsListController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        HelperServices.getTickesListSignal().doNext { (tickets) in
            print(tickets)
        }.start()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.ticketCell.V)
        return cell!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


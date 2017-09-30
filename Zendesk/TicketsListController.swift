//
//  ViewController.swift
//  Zendesk
//
//  Created by andrei on 9/28/17.
//  Copyright © 2017 andrei. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa
import Result

class TicketsListController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let  token = Lifetime.Token()
    var lifeTime:Lifetime
    {
        return Lifetime(token)
    }
    
    let viewModel = TicketsViewModel()
    
    let refreshControl:UIRefreshControl = UIRefreshControl()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 70;
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.addSubview(refreshControl)
        
        
        getTicketsSignal(clearModel: false).start()
        refreshControllSignal().start();
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        guard let rows = viewModel.numberOfCells else {
            return 0
        }
        return rows
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.ticketCell.V) as! TicketCell
        cell.data = self.viewModel.ticketAtIndex(index: indexPath.row)
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getTicketsSignal(clearModel:Bool = false) -> SignalProducer<TicketsList,GeneralError>
    {
        let signal = self.viewModel.getTickets()
            .take(during: lifeTime)
            .onStarting { [weak self] in
                if clearModel {
                    self?.viewModel.clear()
                }
                self?.tableView.reloadData()
                self?.refreshControl.beginRefreshing()
            }.delay(0.5, on: QueueScheduler.main) // added a short delay because the response from the Backend was to quick
            
            .doNext { [weak self] (_) in
                self?.tableView.reloadData()
                self?.refreshControl.endRefreshing()
            }.doError {[weak self] (error) in
                self?.refreshControl.endRefreshing()
                print(error)
                
        }
        
        return signal
    }
    
    
    
    func refreshControllSignal() -> SignalProducer<TicketsList,GeneralError>
    {

        let refreshControllerEventSignal = refreshControl
            .reactive
            .controlEvents(.valueChanged)
            .take(during: lifeTime)
            .flatMap(.latest) { [weak self] (_)  in
                return self?.getTicketsSignal(clearModel:true) ?? SignalProducer.empty
        }
        
        
        let finalSignal = SignalProducer(refreshControllerEventSignal)
            .take(during: lifeTime)
            .continueWithSelfIfError { (error) in
        }
        
        return finalSignal
        
    }
    
    
}


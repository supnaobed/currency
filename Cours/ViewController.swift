//
//  ViewController.swift
//  Cours
//
//  Created by Ishmukhametov on 22.11.15.
//  Copyright © 2015 lenindb. All rights reserved.
//

import UIKit
import Alamofire
import RxSwift
import RxAlamofire
import ObjectMapper

class ViewController: UITableViewController {

    let stringURL = "http://188.166.47.132:8080/exchange/last"
    
    var exchangies = [ExchangeTableViewModel]()
    
    var charcode = String!()
    var startdate = String!()
    var enddate = String!()

    override func viewDidLoad() {
        super.viewDidLoad()
        _ = requestJSON(Method.GET, stringURL)
            .observeOn(MainScheduler.sharedInstance)
            .flatMap{ request -> Observable<([ExchangeTableViewModel])> in
                let exchangeList = Mapper<ExchangeList>().map(request.1)
                var exvhangeVMs = [ExchangeTableViewModel]()
                for exchange in (exchangeList?.exchangies)!{
                    exvhangeVMs.append(ExchangeTableViewModel(exchange))
                }
                return just(exvhangeVMs)
            }
            .subscribe {

                if $0.element != nil {
                    self.exchangies = ($0.element)!
                    self.tableView.reloadData()
                }
                
        }
        
        let calendar = NSCalendar.currentCalendar()
        let daysAgo = calendar.dateByAddingUnit(.Day, value: -10, toDate: NSDate(), options: [])
        let date = calendar.dateByAddingUnit(.Day, value: 0, toDate: NSDate(), options: [])
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY"
        let dateString = dateFormatter.stringFromDate(daysAgo!)
        let currnetDateString = dateFormatter.stringFromDate(date!)
        self.charcode = "USD"
        self.startdate = dateString
        self.enddate = currnetDateString
        
    }
    

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exchangies.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Exch") as! ExchangeTableViewCell
        cell.viewModel = exchangies[indexPath.row]
        return cell
    }
    
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowChart" {
            let chartVC = segue.destinationViewController as! ChartViewController
            chartVC.charcode = self.charcode
            chartVC.startdate = self.startdate
            chartVC.enddate = self.enddate
        }
    }
}

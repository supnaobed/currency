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

class CbrCurrViewController: UITableViewController {

    let stringURL = "http://188.166.47.132:8080/cbr/daily"
    
    var currencies = [CurrencyTableViewModel]()
    var charcode = String!()
    var startdate = String!()
    var enddate = String!()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = requestJSON(Method.GET, stringURL)
            .observeOn(MainScheduler.sharedInstance)
            .flatMap{ request -> Observable<([CurrencyTableViewModel])> in
                let currencyList = Mapper<CbrCurrencyList>().map(request.1)
                var currencyVMs = [CurrencyTableViewModel]()
                for currency in (currencyList?.currencies)!{
                    currencyVMs.append(CurrencyTableViewModel(currency: currency))
                }
                currencyVMs.sortInPlace({ (curt1, curt2) -> Bool in
                    curt1.order < curt2.order
                })
                return just(currencyVMs)
            }
            .subscribe {
                if $0.element != nil {
                    self.currencies = ($0.element)!
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
        return currencies.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CbrCurr") as! CurrencyTableViewCell
        cell.viewModel = currencies[indexPath.row]
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toConvert" {
            let buttonPosition = sender?.convertPoint(CGPoint(), toView: self.tableView)
            if let index = self.tableView.indexPathForRowAtPoint(buttonPosition!) {
                let viewController = segue.destinationViewController as! ConvertorViewController
                let curr = self.currencies[index.row]
                viewController.convertVM = ConvertViewModel(curr.currency)
            }
        } else if segue.identifier == "ShowChart" {
            let buttonPosition = sender?.convertPoint(CGPoint(), toView: self.tableView)
            if let index = self.tableView.indexPathForRowAtPoint(buttonPosition!) {
                let curr = self.currencies[index.row]
                let chartVC = segue.destinationViewController as! ChartViewController
                chartVC.charcode = curr.charCode
                chartVC.startdate = self.startdate
                chartVC.enddate = self.enddate
            }
            
        }
        
    }
}

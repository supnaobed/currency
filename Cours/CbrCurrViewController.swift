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
import RealmSwift

class CbrCurrViewController: BaseController  {

    @IBOutlet weak var courcesDate: UILabel!

    var viewModels = [CurrencyTableViewModel]()
    var charcode = String!()
    var startdate = String!()
    var enddate = String!()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    override func getDisp() -> Disposable {
        let operationQueue = NSOperationQueue()
        operationQueue.maxConcurrentOperationCount = 3
        operationQueue.qualityOfService = NSQualityOfService.UserInitiated
        let backgroundWorkScheduler = OperationQueueScheduler(operationQueue: operationQueue)
        print(Realm.Configuration.defaultConfiguration.path!)
        return Data.featchCrbList()
            .flatMap { () -> Observable<CbrCurrencyList> in
                let eList = try! Realm().objects(CbrCurrencyList).sorted("time")
                return just(eList.first!)
            }
            .doOn({ eList -> Void in
                self.courcesDate.text = "Курс валют за \(self.date(Int64((eList.element?.time)!)/1000))"
            })
            .flatMap{ list -> Observable<([CurrencyTableViewModel])> in
                var currencyVMs = [CurrencyTableViewModel]()
                for currency in (list.currencies){
                    currencyVMs.append(CurrencyTableViewModel(currency: currency))
                }
                currencyVMs.sortInPlace({ (curt1, curt2) -> Bool in
                    curt1.order < curt2.order
                })
                return just(currencyVMs)
                
            }
            .subscribeOn(backgroundWorkScheduler)
            .observeOn(MainScheduler.sharedInstance)
            .subscribe {
                if $0.element != nil {
                    self.viewModels = ($0.element)!
                    self.tableView.reloadData()
                }
                self.refreshControl!.endRefreshing()
        }
    }
    
    
    override func getCount() -> Int {
        return viewModels.count
    }
    
    override func getCell(index: Int) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CbrCurr") as! CurrencyTableViewCell
        cell.viewModel = self.viewModels[index]
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toConvert" {
            let buttonPosition = sender?.convertPoint(CGPoint(), toView: self.tableView)
            if let index = self.tableView.indexPathForRowAtPoint(buttonPosition!) {
                let viewController = segue.destinationViewController as! ConvertorViewController
                let curr = self.viewModels[index.row]
                viewController.convertVM = ConvertViewModel(curr.currency)
            }
        } else if segue.identifier == "ShowChart" {
            let buttonPosition = sender?.convertPoint(CGPoint(), toView: self.tableView)
            if let index = self.tableView.indexPathForRowAtPoint(buttonPosition!) {
                let curr = self.viewModels[index.row]
                let chartVC = segue.destinationViewController as! ChartViewController
                chartVC.charcode = curr.charCode
                chartVC.startdate = self.startdate
                chartVC.enddate = self.enddate
            }
            
        }
        
    }
}

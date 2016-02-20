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

class ViewController: BaseController {

    @IBOutlet weak var courcesDate: UILabel!
    
    var viewModels = [ExchangeTableViewModel]()
    
    
    override func getDisp() -> Disposable {
        let operationQueue = NSOperationQueue()
        operationQueue.maxConcurrentOperationCount = 3
        operationQueue.qualityOfService = NSQualityOfService.UserInitiated
        let backgroundWorkScheduler = OperationQueueScheduler(operationQueue: operationQueue)
        print(Realm.Configuration.defaultConfiguration.path!)
        if dispos != nil {
            dispos.dispose()
        }
        return Data.getExchangeListTime()
            .flatMap { time -> Observable<ExchangeList> in
                let eList = try! Realm().objects(ExchangeList).sorted("time")
                return just(eList.first!)
            }
            .doOn({ eList -> Void in
                self.courcesDate.text = "Курс валют за \(self.date(Int64((eList.element?.time)!)/1000))"
            })
            .flatMap{ exchangeList -> Observable<([ExchangeTableViewModel])> in
                var exvhangeVMs = [ExchangeTableViewModel]()
                for exchange in (exchangeList.exchangies){
                    exvhangeVMs.append(ExchangeTableViewModel(exchange))
                }
                return just(exvhangeVMs)
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
        let cell = tableView.dequeueReusableCellWithIdentifier("Exch") as! ExchangeTableViewCell
        cell.viewModel = viewModels[index]
        return cell
    }
    
      
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

    }
    
}

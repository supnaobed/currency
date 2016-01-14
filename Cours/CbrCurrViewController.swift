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

    override func viewDidLoad() {
        super.viewDidLoad()
        _ = requestJSON(Method.GET, stringURL)
            .observeOn(MainScheduler.sharedInstance)
            .flatMap{ request -> Observable<([CurrencyTableViewModel])> in
                let currencyList = Mapper<CbrCurrencyList>().map(request.1)
                var currencyVMs = [CurrencyTableViewModel]()
                for currency in (currencyList?.currencies)!{
                    currencyVMs.append(CurrencyTableViewModel(currency))
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
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CbrCurr") as! CurrencyTableViewCell
        cell.viewModel = currencies[indexPath.row]
        return cell
    }
}

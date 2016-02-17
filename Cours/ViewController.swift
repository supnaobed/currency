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

class ViewController: UITableViewController {

    let stringURL = "http://188.166.47.132:8080/exchange/last"
    
    var exchangies = [ExchangeTableViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        if (true){
            _ = Data.getExchangeList()
                .observeOn(MainScheduler.sharedInstance)
                .flatMap{ exchangeList -> Observable<([ExchangeTableViewModel])> in
                    var exvhangeVMs = [ExchangeTableViewModel]()
                    for exchange in (exchangeList.exchangies){
                        exvhangeVMs.append(ExchangeTableViewModel(exchange))
                    }
                    return just(exvhangeVMs)
                }
                .subscribe {
                    if $0.element != nil {
                        print(Realm.Configuration.defaultConfiguration.path!)
                        self.exchangies = ($0.element)!
                        self.tableView.reloadData()
                    }
                }
        }else{
            
        }
        
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

    }
}

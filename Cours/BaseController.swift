//
//  BaseController.swift
//  Cours
//
//  Created by Ishmukhametov on 19.02.16.
//  Copyright © 2016 lenindb. All rights reserved.
//

import UIKit
import Alamofire
import RxSwift
import RxAlamofire
import ObjectMapper
import RealmSwift

class BaseController: UITableViewController {

    var dispos: Disposable!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.backgroundColor = UIColor.whiteColor()
        self.refreshControl!.tintColor = UIColor.blackColor()
        self.refreshControl!.addTarget(self, action: "featch:", forControlEvents:UIControlEvents.ValueChanged)
        self.refreshControl!.beginRefreshing()
        featch("")
    }
    
    func getCount() -> Int{
        return 0
    }
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func featch(sender:AnyObject){
        if dispos != nil {
            dispos.dispose()
        }
        dispos = getDisp()
    }
    
    func getDisp() -> Disposable{
        return just(1).subscribeNext({ (i) -> Void in
            print("need override getdisp!")
        })
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getCount()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return getCell(indexPath.row)
    }
    
    func getCell(index: Int) -> UITableViewCell{
        return UITableViewCell()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if (getCount() == 0) {
            let messageLbl = UILabel(frame: CGRectMake(0, 0,
                self.tableView.bounds.size.width,
                self.tableView.bounds.size.height));
            messageLbl.text = "Нет доступных данных"
            messageLbl.textAlignment = NSTextAlignment.Center
            messageLbl.sizeToFit()
            self.tableView.backgroundView = messageLbl;
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
            return 0
        }
        return 1
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        self.dispos.dispose()
    }
    
    func date(dateInt: Int64)-> String{
        let timeInterval = NSTimeInterval.init(integerLiteral: dateInt)
        let date = NSDate(timeIntervalSince1970: timeInterval)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY"
        return dateFormatter.stringFromDate(date)
    }
    
}

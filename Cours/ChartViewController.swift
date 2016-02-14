
//
//  ChartViewController.swift
//  Cours
//
//  Created by Ishmukhametov on 01.12.15.
//  Copyright © 2015 lenindb. All rights reserved.
//

import UIKit
import Alamofire
import RxSwift
import RxAlamofire
import ObjectMapper
import SwiftyJSON
import Charts


class ChartViewController: UIViewController, ChartViewDelegate {

    @IBOutlet weak var chartView: LineChartView!
    
    let stringURL = "http://188.166.47.132:8080/cbr/dynamic"
    
    var charcode = String!()
    var startdate = String!()
    var enddate = String!()
    var titlies = [String]()
    var dataEntry = [ChartDataEntry]()

    override func viewDidLoad() {
        super.viewDidLoad()
        chartView.delegate = self;
        chartView.descriptionText = "Currency";
        chartView.noDataTextDescription = "Data will be loaded soon."
        chartView.dragEnabled = false;
        chartView.pinchZoomEnabled = false
        chartView.legend.enabled = false
        let leftAxis = chartView.leftAxis;
        let rightAxis = chartView.rightAxis;
        leftAxis.drawGridLinesEnabled = false;
        rightAxis.drawGridLinesEnabled = false;
        rightAxis.enabled = false
        rightAxis.setLabelCount(50, force: false)
        chartView.leftAxis.startAtZeroEnabled = false
        chartInit()
        _ = requestJSON(Method.GET, stringURL, parameters: ["charcode":charcode, "startdate":startdate, "enddate":enddate])
            .observeOn(MainScheduler.sharedInstance)
            .map{ request -> [String: Currency] in
                let curr = Mapper<Currency>().mapDictionary(request.1)
                return curr!
            }.flatMap({ (ts) -> Observable<(String, Currency)> in
                return ts.toObservable()
            }).map({ (title, curs) -> (String, Double) in
                return (title, Double(curs.value))
            }).map({ (dateStr, curs) -> (Int64, Double) in
                return (Int64(dateStr)!/1000, curs)
            }).toArray()
            .flatMap({ (arr) -> Observable<(Int64, Double)> in
                let arrSorted = arr.sort({ (first, second) -> Bool in
                    return first.0 < second.0
                })
                return arrSorted.toObservable()
            }).subscribe{curs -> () in
                if let item = curs.element{
                    self.titlies.append(self.date(item.0))
                    self.dataEntry.append(ChartDataEntry(value: item.1, xIndex: self.dataEntry.count))
                }
                self.chartInit()
                self.chartView.reloadInputViews()
                
            }
    }
    
    func date(dateInt: Int64)-> String{
        let timeInterval = NSTimeInterval.init(integerLiteral: dateInt)
        let date = NSDate(timeIntervalSince1970: timeInterval)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd.MM"
        return dateFormatter.stringFromDate(date)
    }
    
    func chartInit(){
        var yVals: [LineChartDataSet] = []
        let set = LineChartDataSet(yVals: dataEntry);
        set.drawCubicEnabled = true
        set.drawFilledEnabled = true
        set.fillFormatter = CubicLineSampleFillFormatter()
        set.cubicIntensity = 0.2;
        set.drawCirclesEnabled = false;
        set.lineWidth = 1.8;
        set.circleRadius = 4.0;
        set.setCircleColor(UIColor(red: 10/255, green: 220/255, blue: 150/255, alpha: 1))
        set.setColor(UIColor(red: 10/255, green: 220/255, blue: 150/255, alpha: 1))
        set.fillColor = UIColor(red: 10/255, green: 220/255, blue: 150/255, alpha: 1)
        set.fillAlpha = 1;
        yVals.append(set)
        let data = LineChartData(xVals: titlies, dataSets: yVals)
        self.chartView.data = data
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

    
    class CubicLineSampleFillFormatter : ChartFillFormatter{
        @objc func getFillLinePosition(dataSet dataSet: LineChartDataSet, dataProvider: LineChartDataProvider) -> CGFloat {
            return -1
        }
    }


}

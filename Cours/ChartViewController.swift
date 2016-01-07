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

    override func viewDidLoad() {
        super.viewDidLoad()
        chartView.delegate = self;
        chartView.descriptionText = "Currency";
        chartView.noDataTextDescription = "Data will be loaded soon."
        chartView.dragEnabled = true;
        let yAxis = chartView.leftAxis;
        let xAxis = chartView.rightAxis;
        yAxis.drawGridLinesEnabled = false;
        xAxis.drawGridLinesEnabled = false;
        xAxis.enabled = false
        xAxis.setLabelCount(5, force: false)
        _ = requestJSON(Method.GET, stringURL, parameters: ["charcode":charcode, "startdate":startdate, "enddate":enddate])
            .observeOn(MainScheduler.sharedInstance)
            .map{ request -> [String: Currency] in
                let curr = Mapper<Currency>().mapDictionary(request.1)
                return curr!
            }.subscribe{currencies -> () in
                var titlies = [String]()
                var dataEntry = [ChartDataEntry]()
                if let items = currencies.element {
                    for (index, item) in items.enumerate(){
                        titlies.append(item.0)
                        dataEntry.append(ChartDataEntry(value: Double(item.1.value), xIndex: index))
                    }
                    var yVals: [LineChartDataSet] = []
                    let set1 = LineChartDataSet(yVals: dataEntry);
                    set1.drawCubicEnabled = true;
                    set1.cubicIntensity = 0.2;
                    set1.drawCirclesEnabled = false;
                    set1.lineWidth = 1.8;
                    set1.circleRadius = 4.0;
                    set1.setCircleColor(UIColor.greenColor())
                    set1.highlightColor = UIColor(colorLiteralRed:Float(244/Float(255)), green:Float(117/Float(255)), blue:Float(117/Float(255)), alpha:1)
                    set1.setColor(UIColor.greenColor())
                    set1.fillColor = UIColor.greenColor()
                    set1.fillAlpha = 0;
                    set1.drawHorizontalHighlightIndicatorEnabled = false;
                    set1.fillFormatter = CubicLineSampleFillFormatter()
                    yVals.append(set1)
                    let data = LineChartData(xVals: titlies, dataSets: yVals)
                    self.chartView.data = data
                }
                
        }
    
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

//
//  Exchange.swift
//  Cours
//
//  Created by Ishmukhametov on 29.11.15.
//  Copyright © 2015 lenindb. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

public class Exchange: Object, Mappable {
    dynamic var bank: String = ""
    dynamic var usdBuy: Float = 0.0
    dynamic var usdSell: Float = 0.0
    dynamic var euroBuy: Float = 0.0
    dynamic var euroSell: Float = 0.0
    dynamic var url: String = ""
    
//    public init?() {
//        // Empty Constructor
//    }
//    
    required convenience public init?(_ map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        bank        <- map["bank"]
        usdBuy      <- map["usdBuy"]
        usdSell     <- map["usdSell"]
        euroBuy     <- map["euroBuy"]
        euroSell    <- map["euroSell"]
        url         <- map["url"]
    }
}
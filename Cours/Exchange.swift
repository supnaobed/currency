//
//  Exchange.swift
//  Cours
//
//  Created by Ishmukhametov on 29.11.15.
//  Copyright © 2015 lenindb. All rights reserved.
//

import Foundation
import ObjectMapper

public class Exchange: Mappable {
    var bank: String!
    var usdBuy: Float!
    var usdSell: Float!
    var euroBuy: Float!
    var euroSell: Float!
    var url: String!
    
    public init?() {
        // Empty Constructor
    }
    
    required public init?(_ map: Map) {
        mapping(map)
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
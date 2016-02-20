//
//  CbrCurrencyList.swift
//  Cours
//
//  Created by Ishmukhametov on 11.01.16.
//  Copyright © 2016 lenindb. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

public class CbrCurrencyList: Object, Mappable{
    dynamic var time: Int = 0
    var currencies = List<CbrCurrency>()
    
    required convenience public init?(_ map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        time       <- map["date"];
        currencies <- (map["currencies"], ArrayTransform<CbrCurrency>())
    }
}

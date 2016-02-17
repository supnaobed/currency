//
//  ExchangeList.swift
//  Cours
//
//  Created by Ishmukhametov on 29.11.15.
//  Copyright © 2015 lenindb. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

public class ExchangeList: Object, Mappable{
    
    dynamic var time = 0
    var exchangies = List<Exchange>()
    
    required convenience public init?(_ map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        time <- map["time"];
        exchangies <- (map["exchangeList"], ArrayTransform<Exchange>())

    }
    
    
    
}

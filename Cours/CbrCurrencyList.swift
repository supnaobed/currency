//
//  CbrCurrencyList.swift
//  Cours
//
//  Created by Ishmukhametov on 11.01.16.
//  Copyright © 2016 lenindb. All rights reserved.
//

import Foundation
import ObjectMapper

public class CbrCurrencyList: Mappable{
    var date: Int64!
    var currencies: [CbrCurrency]!
    
    public init?(){
        
    }
    
    required public init?(_ map :Map){
        mapping(map)
    }
    
    public func mapping(map: Map) {
        date       <- map["date"];
        currencies <- map["currencies"];
    }
}

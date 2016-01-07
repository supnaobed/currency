//
//  ExchangeList.swift
//  Cours
//
//  Created by Ishmukhametov on 29.11.15.
//  Copyright © 2015 lenindb. All rights reserved.
//

import Foundation
import ObjectMapper

public class ExchangeList: Mappable{
    
    var time: Int64!
    var exchangies: [Exchange]!
    
    public init?(){
        
    }
    
    required public init?(_ map :Map){
        mapping(map)
    }
    
    public func mapping(map: Map) {
        time <- map["time"];
        exchangies <- map["exchangeList"];
    }
    
    
    
}

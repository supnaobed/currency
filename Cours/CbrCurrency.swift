//
//  CbrCurrency.swift
//  Cours
//
//  Created by Ishmukhametov on 11.01.16.
//  Copyright © 2016 lenindb. All rights reserved.
//

import Foundation
import ObjectMapper

public class CbrCurrency: Mappable{
    
    var id: String!
    var name: String!
    var charCode: String!
    var nominal: Int!
    var value: Float!
    var numCode: Int!
    var changed: Float!
    var order: Int!
    
    public init?() {
        // Empty Constructor
    }
    
    required public init?(_ map: Map) {
        mapping(map)
    }
    
    public func mapping(map: Map) {
        id       <- map["id"]
        name     <- map["name"]
        charCode <- map["charCode"]
        nominal  <- map["nominal"]
        value    <- map["value"]
        numCode  <- map["numCode"]
        changed  <- map["changed"]
        order    <- map["order"]
    }
    
}
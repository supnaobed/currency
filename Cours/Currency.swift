//
//  Dynamic.swift
//  Cours
//
//  Created by Ishmukhametov on 01.12.15.
//  Copyright © 2015 lenindb. All rights reserved.
//
import Foundation
import ObjectMapper

public class Currency: Mappable {
    var value: Float!
    
    public init?() {
        // Empty Constructor
    }
    
    required public init?(_ map: Map) {
        mapping(map)
    }
    
    public func mapping(map: Map) {
        value     <- map["value"]
    }
}
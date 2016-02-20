//
//  CbrCurrency.swift
//  Cours
//
//  Created by Ishmukhametov on 11.01.16.
//  Copyright © 2016 lenindb. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

public class CbrCurrency: Object, Mappable{
    
    dynamic var id: String = ""
    dynamic var name: String = ""
    dynamic var charCode: String = ""
    dynamic var nominal: Int = 0
    dynamic var value: Float = 0
    dynamic var numCode: Int = 0
    dynamic var changed: Float = 0
    dynamic var order: Int = 0
    
    required convenience public init?(_ map: Map) {
        self.init()
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
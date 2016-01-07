//
//  Post.swift
//  Cours
//
//  Created by Ishmukhametov on 23.11.15.
//  Copyright © 2015 lenindb. All rights reserved.
//

import Foundation
import ObjectMapper

public class Post: Mappable {
    var userId: Int!
    var id: Int!
    var title: String!
    var body: String!

    public init?() {
        // Empty Constructor
    }
    
    required public init?(_ map: Map) {
        mapping(map)
    }
    
    public func mapping(map: Map) {
        userId     <- map["userId"]
        id         <- map["id"]
        title      <- map["title"]
        body       <- map["body"]
    }
}

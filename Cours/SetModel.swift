//
//  SetModel.swift
//  Cours
//
//  Created by Ishmukhametov on 19.02.16.
//  Copyright © 2016 lenindb. All rights reserved.
//

import Foundation

protocol SetModel{
    typealias TypeViewModel
    var viewModel: TypeViewModel{get set}
}

extension SetModel{
    mutating func bind(viewModel: TypeViewModel){
        self.viewModel = viewModel
    }
}



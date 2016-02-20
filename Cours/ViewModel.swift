//
//  ExchangeViewModel.swift
//  Cours
//
//  Created by Ishmukhametov on 29.11.15.
//  Copyright © 2015 lenindb. All rights reserved.
//

import Foundation

protocol ExchangeViewModel: ViewModel {
    var exchange:Exchange{ get }
    var bank:    String  { get }
    var usdSell: Float32 { get }
    var usdBuy:  Float32 { get }
    var eurSell: Float32 { get }
    var eurBuy:  Float32 { get }
}

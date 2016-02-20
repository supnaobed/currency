//
//  ExchangeTableViewModel.swift
//  Cours
//
//  Created by Ishmukhametov on 29.11.15.
//  Copyright © 2015 lenindb. All rights reserved.
//

import Foundation

class ExchangeTableViewModel: ExchangeViewModel {
    
    let exchange: Exchange
    let bank: String
    let usdSell: Float
    let usdBuy: Float
    let eurBuy: Float
    let eurSell: Float

    init(_ exchange: Exchange){
        self.exchange = exchange
        self.bank = exchange.bank
        self.usdSell = exchange.usdSell
        self.usdBuy = exchange.usdBuy
        self.eurBuy = exchange.euroBuy
        self.eurSell = exchange.euroSell
    }

}

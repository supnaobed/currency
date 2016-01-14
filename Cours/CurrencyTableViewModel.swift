//
//  ExchangeTableViewModel.swift
//  Cours
//
//  Created by Ishmukhametov on 29.11.15.
//  Copyright © 2015 lenindb. All rights reserved.
//

import Foundation

class CurrencyTableViewModel: CurrencyViewModel {
    
    let currency: CbrCurrency
    let charCode: String
    let name: String
    let nominal: Int
    let value: Float
    let changed: Float
    let order: Int

    init(_ currency: CbrCurrency){
        self.currency = currency
        self.charCode = currency.charCode
        self.nominal = currency.nominal
        self.value = currency.value
        self.changed = currency.changed
        self.order = currency.order
        self.name = currency.name
    }

}

//
//  ConvertViewModel.swift
//  Cours
//
//  Created by Ishmukhametov on 17.01.16.
//  Copyright © 2016 lenindb. All rights reserved.
//

import Foundation

class ConvertViewModel {
    
    let currency: CbrCurrency
    
    var course: String
    
    var convertDelegat: ConverDelegat?
    
    var reverce: Bool!
    
    var value: String? {
        didSet{
            if value == ""{
                convertDelegat!.newConvertResult("0.0")
            } else {
                if let current = Float(value!) {
                    let coef = reverce! ? (1/currency.value):currency.value
                    convertDelegat!.newConvertResult(String(current * coef))
                }
            }
        }
    }
    

    init(_ currency: CbrCurrency){
        self.currency = currency
        course = "\(currency.nominal) \(currency.charCode) = \(currency.value) RUB"
        reverce = false
    }
    
    func reverceConvert() {
        reverce = !reverce
        convertDelegat!.reverceConvert(reverce)
    }
    
}

//
//  ExchangeViewModel.swift
//  Cours
//
//  Created by Ishmukhametov on 29.11.15.
//  Copyright © 2015 lenindb. All rights reserved.
//

import Foundation

protocol CurrencyViewModel {
    var charCode: String { get }
    var name: String { get }
    var nominal: Int { get }
    var value: Float { get }
    var changed: Float { get }
    var order: Int { get }
}

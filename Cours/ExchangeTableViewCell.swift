//
//  ExchangeTableViewCell.swift
//  Cours
//
//  Created by Ishmukhametov on 29.11.15.
//  Copyright © 2015 lenindb. All rights reserved.
//

import Foundation
import UIKit

class ExchangeTableViewCell: UITableViewCell{
    
    @IBOutlet  var bankLabel: UILabel!
    @IBOutlet  var usdSellLabel: UILabel!
    @IBOutlet  var usdBuyLabel: UILabel!
    @IBOutlet  var eurBuyLabel: UILabel!
    @IBOutlet  var eurSellLabel: UILabel!

    var viewModel: ExchangeViewModel!{
        didSet{
            bankLabel.text = viewModel.bank
            usdSellLabel.text = String(viewModel.usdSell)
            usdBuyLabel.text = String(viewModel.usdBuy)
            eurBuyLabel.text = String(viewModel.eurBuy)
            eurSellLabel.text = String(viewModel.eurSell)
        }
    }
    
    override  func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override  func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

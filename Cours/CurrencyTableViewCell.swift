//
//  ExchangeTableViewCell.swift
//  Cours
//
//  Created by Ishmukhametov on 29.11.15.
//  Copyright © 2015 lenindb. All rights reserved.
//

import Foundation
import UIKit

class CurrencyTableViewCell: UITableViewCell{
    
    @IBOutlet  var charLabel: UILabel!
    @IBOutlet  var valueLabel: UILabel!
    @IBOutlet  var changedLabel: UILabel!
    @IBOutlet  var nameLabel: UILabel!
    

    var viewModel: CurrencyViewModel!{
        didSet{
            charLabel.text = "\(viewModel.nominal) \(viewModel.charCode)"
            valueLabel.text = String(viewModel.value)
            changedLabel.text = String(viewModel.changed)
            nameLabel.text = viewModel.name
        }
    }
    
    override  func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override  func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

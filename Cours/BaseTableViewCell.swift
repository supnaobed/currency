//
//  ExchangeTableViewCell.swift
//  Cours
//
//  Created by Ishmukhametov on 29.11.15.
//  Copyright © 2015 lenindb. All rights reserved.
//

import Foundation
import UIKit

class BaseTableViewCell<T: ViewModel>: UITableViewCell{
    

    var viewModel: T!
    
    override  func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override  func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

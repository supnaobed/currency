//
//  CoursController.swift
//  Cours
//
//  Created by Ishmukhametov on 07.01.16.
//  Copyright © 2016 lenindb. All rights reserved.
//

import UIKit

class CoursController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.items![0].image = UIImage(named: "bag.png")
        self.tabBar.items![1].image = UIImage(named: "banknote.png")
        self.tabBar.items![0].title = "Курсы банков"
        self.tabBar.items![1].title = "Курсы банков"

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}

//
//  ConvertorViewController.swift
//  Cours
//
//  Created by Ishmukhametov on 13.01.16.
//  Copyright © 2016 lenindb. All rights reserved.
//

import UIKit
import Alamofire
import RxSwift
import RxAlamofire
import ObjectMapper

class ConvertorViewController: UIViewController, ConverDelegat {
    
    @IBOutlet weak var curce: UILabel!
    @IBOutlet weak var from: UILabel!
    @IBOutlet weak var to: UILabel!
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var input: UITextField!
    @IBAction func textFieldDidChange(sender: UITextField) {
        convertVM.value = sender.text
    }
    
    @IBAction func reverce(sender: UIButton) {
        convertVM.reverceConvert()
        convertVM.value = input.text
    }
    
    
    var convertVM: ConvertViewModel!{
        didSet{
            convertVM.convertDelegat = self
        }
    }
    
    override func viewDidLoad() {
        curce.text = convertVM.course
        to.text = "RUB"
        from.text = convertVM.currency.charCode
    }
    
    func newConvertResult(value: String) {
        result.text = value
    }
    
    func reverceConvert(value: Bool) {
        if (value){
            from.text = "RUB"
            to.text = convertVM.currency.charCode
        }else{
            to.text = "RUB"
            from.text = convertVM.currency.charCode
        }
    }
    
}

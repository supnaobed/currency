//
//  Data.swift
//  Cours
//
//  Created by Ishmukhametov on 17.02.16.
//  Copyright © 2016 lenindb. All rights reserved.
//

import Foundation
import RxSwift
import RxAlamofire
import Alamofire
import ObjectMapper
import RealmSwift

class Data {
    static let stringURL = "http://188.166.47.132:8080/exchange/last"
    
    static func getExchangeList() -> Observable<ExchangeList>{
        let realm = try! Realm()
        return create({ (observer) -> Disposable in
            RxAlamofire.requestJSON(Method.GET, self.stringURL)
                .subscribe(onNext: { response -> Void in
                    if let exchangeList = Mapper<ExchangeList>().map(response.1){
                        try! realm.write {
                            realm.add(exchangeList)
                        }
                        observer.onNext(exchangeList)
                    }
                    }, onError: { (e) -> Void in
                        if e._code == -1009 {
                            if let eList = realm.objects(ExchangeList).sorted("time").first{
                                observer.onNext(eList)
                            }
                        }
                })
        })
    }

    
}

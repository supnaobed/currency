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
    static let urlCrbDaily = "http://188.166.47.132:8080/cbr/daily"

    
    internal static func getExchangeListTime() -> Observable<Int>{
        let realm = try! Realm()
        return create({ (observer) -> Disposable in
            return RxAlamofire.requestJSON(Method.GET, self.stringURL)
                .subscribe(onNext: { response -> Void in
                    if let exchangeList = Mapper<ExchangeList>().map(response.1){
                        if let eList = realm.objects(ExchangeList).sorted("time").first{
                            try! realm.write {
                                eList.exchangies.forEach({ (exh) -> () in
                                    realm.delete(exh)
                                })
                                realm.delete(eList)
                            }
                        }
                        try! realm.write {
                            realm.add(exchangeList)
                        }
                        observer.onNext(exchangeList.time)
                    }
                    }, onError: { (e) -> Void in
                        if e._code == -1009 {
                            if let eList = realm.objects(ExchangeList).sorted("time").first{
                                observer.onNext(eList.time)
                            }
                        }
                })
        })
    }
    
    internal static func getListTime<L where L: Mappable, L: Object>(url: String, l:L, delete: (L, (Object)->()) -> ()) -> Observable<Void>{
        let realm = try! Realm()
        return create({ (observer) -> Disposable in
            return RxAlamofire.requestJSON(Method.GET, url)
                .subscribe(onNext: { response -> Void in
                    if let exchangeList = Mapper<L>().map(response.1){
                        if let eList = realm.objects(L).last{
                            try! realm.write {
                                delete(eList, {(el) -> () in
                                realm.delete(el)
                                })
                                realm.delete(eList)
                            }
                        }
                        try! realm.write {
                            realm.add(exchangeList)
                        }
                        observer.onNext()
                    }
                    }, onError: { (e) -> Void in
                        if e._code == -1009 {
                            if let _ = realm.objects(L).last{
                                observer.onNext()
                            }
                        }
                })
        })
    }

    internal static func featchCrbList() -> Observable<Void>{
        return getListTime(urlCrbDaily, l: CbrCurrencyList()){ (list, deleteFromRealm) -> () in
            list.currencies.forEach({ (el) -> () in
                deleteFromRealm(el)
            })
        }
    }
    
}


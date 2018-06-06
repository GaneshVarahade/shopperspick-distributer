//
//  RealmUtil.swift
//  CodableRealm
//
//  Created by Apple on 30/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

fileprivate class RealmSingleton {
    
    private init(){
        
    }
    private static var realmSingleton:RealmSingleton!
    
    public static func sharedInstance() -> RealmSingleton{
        realmSingleton = RealmSingleton()
        return realmSingleton
    }
    
    private var realm: Realm = try! Realm()
    
    public func getRealm() -> Realm {
        return realm
    }
}

public class RealmManager <T: ModelBase>{
    
    
    public func write<T: ModelBase>(table: T) {
        try! getRealm().write {
            getRealm().add(table.copy() as! Object,update: true)
        }
    }
    
    public func read<T: ModelBase>(type: T.Type,primaryKey: String) -> T? {
        return getRealm().object(ofType: type, forPrimaryKey: primaryKey)
    } 
    
    public func readList<T: ModelBase>(type: T.Type) -> Results<T>? {
        return getRealm().objects(type)
    }
    
    public func readPredicate<T: ModelBase>(type: T.Type,predicate: String) -> Results<T>?{
        return getRealm().objects(type).filter(predicate)
    }
    
    public func getRealm() -> Realm {
        return RealmSingleton.sharedInstance().getRealm()
    }
     
}

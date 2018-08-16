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
    
    private static var realmSingleton:RealmSingleton!
    
    public static func sharedInstance() -> RealmSingleton{
        realmSingleton = RealmSingleton()
        return realmSingleton
    }
    
    let config = Realm.Configuration(
        // Set the new schema version. This must be greater than the previously used
        // version (if you've never set a schema version before, the version is 0).
        schemaVersion: 1,
        
        // Set the block which will be called automatically when opening a Realm with
        // a schema version lower than the one set above
        migrationBlock: { migration, oldSchemaVersion in
            
        }
    )
    private var realm: Realm!
    public func getRealm() -> Realm {
        return realm
    }
    
    private init(){
        Realm.Configuration.defaultConfiguration = config
        realm = try! Realm()
    }
}

public class RealmManager <T: ModelBase>{
    
    
    public func write<T: ModelBase>(table: T) {
        try! getRealm().write {
            getRealm().add(table.copy() as! Object,update: true)
        }
    }
    
    public func write<T: ModelBase>(_ list:[T]) {
        for obj in list {
            write(table: obj)
        }
    }
    
    public func read<T: ModelBase>(type: T.Type,primaryKey: String) -> T? {
        return (getRealm().object(ofType: type, forPrimaryKey: primaryKey))?.copy() as? T
    } 
    
    public func readList<T: ModelBase>(type: T.Type) -> [T] {
        let result: Results<T>? = getRealm().objects(type)
        var array:[T] = [T]()
        guard let resultObj = result else {
            return array
        }
        
        for obj in resultObj {
                array.append(obj.copy() as! T)
        }
        return array
    }
    
    public func readList<T: ModelBase>(type: T.Type,distinct: String) -> [T] {
        let result: Results<T>? = getRealm().objects(type).distinct(by: [distinct])
        var array:[T] = [T]()
        guard let resultObj = result else {
            return array
        }
        
        for obj in resultObj {
            array.append(obj.copy() as! T)
        }
        return array
    }
    public func readPredicate<T: ModelBase>(type: T.Type,distinct: String,predicate: String) -> [T]{
        let result: Results<T>? = getRealm().objects(type).distinct(by: [distinct]).filter(predicate)
        var array:[T] = [T]()
        guard let resultObj = result else {
            return array
        }
        
        for obj in resultObj {
            array.append(obj.copy() as! T)
        }
        return array
    }
    public func readPredicate<T: ModelBase>(type: T.Type,predicate: String) -> [T]{
        let result: Results<T>? = getRealm().objects(type).filter(predicate)
        var array:[T] = [T]()
        guard let resultObj = result else {
            return array
        }
        
        for obj in resultObj {
            array.append(obj.copy() as! T)
        }
        return array
    }

    public func deletePredicate<T: ModelBase>(type: T.Type, predicate: String){
        
        try! getRealm().write {
            getRealm().delete(getRealm().objects(type).filter(predicate))
        }
        
    }
    
    public func deleteAll<T: ModelBase>(type: T.Type){
        
        try! getRealm().write {
            getRealm().delete(getRealm().objects(type))
        }
        
    }
    private func getRealm() -> Realm {
        return RealmSingleton.sharedInstance().getRealm()
    }
}

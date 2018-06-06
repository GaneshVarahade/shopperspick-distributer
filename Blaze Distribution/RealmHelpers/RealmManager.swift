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
    
    public func getRealm() -> Realm {
        return RealmSingleton.sharedInstance().getRealm()
    }
     
}

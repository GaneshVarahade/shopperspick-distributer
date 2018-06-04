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

public class BaseDao <T: Object>{
    
    
    public func write<T>(table: T) {
        fatalError("Subclass need to implement this method")
    }
    
    public func read<T>(primaryKey: String) -> T? {
        fatalError("Subclass need to implement this method")
    } 
    
    public func getRealm() -> Realm {
        return RealmSingleton.sharedInstance().getRealm()
    }
     
}

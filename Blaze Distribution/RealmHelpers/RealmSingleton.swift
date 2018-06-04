//
//  RealmSingleton.swift
//  CodableRealm
//
//  Created by Apple on 04/06/18.
//  Copyright © 2018 Apple. All rights reserved.
//


import Foundation
import Realm
import RealmSwift

public class RealmSingleton {
    
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

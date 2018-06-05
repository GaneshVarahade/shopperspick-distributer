//
//  DBManager.swift
//  Blaze Distribution
//
//  Created by Fidel iOS on 01/06/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class DBManager {
    private var   database:Realm
    static let   sharedInstance = DBManager()
    
    private init() {
        database = try! Realm()
    }
    func getDataFromDB(object:Any) ->  Results<Object>{
        let results =   database.objects(object as! Object.Type)
        return results
    }
    func addData(object: Object)   {
        try! database.write {
            database.add(object, update: true)
           // print("Added new object")
        }
    }
    func deleteAllFromDatabase()  {
        try!   database.write {
            database.deleteAll()
        }
    }
    func deleteFromDb(object: Object)   {
        try!   database.write {
            database.delete(object)
        }
    }
}

//
//  UtilWriteLogs.swift
//  Blaze Distribution
//
//  Created by Apple on 16/07/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation
import  Realm
import RealmSwift
public class UtilWriteLogs {
    //read currunt time in string
public static let curruntDate = DateFormatterUtil.format(dateTime: Double(Date().timeIntervalSince1970), format: DateFormatterUtil.yyyyMMddHHmm)
    
    public static func writeLog(timesStamp: String?, event:String?,objectId:String?,lastSynch:String?){
      let objTimeStamp = ModelTimesStampLog()
        objTimeStamp.id = HexGenerator.sharedInstance().generate()
        objTimeStamp.timesStamp = timesStamp
        objTimeStamp.event = event
        objTimeStamp.objectId = objectId ?? "--"
        objTimeStamp.lastSyncTime = lastSynch ?? "--"
        RealmManager().write(table: objTimeStamp)
        //print(RealmManager().readList(type: ModelTimesStampLog.self))
        UtilPrintLogs.requestLogs(message:"Times stamp info", objectToPrint: RealmManager().readList(type: ModelTimesStampLog.self))
}
    
    public static func updateLog(id:String,timesStamp: String?, event:String?,objectId:String?,lastSynch:String?){
        let objTimeStamp = ModelTimesStampLog()
        objTimeStamp.id = id
        objTimeStamp.timesStamp = timesStamp ?? "--"
        objTimeStamp.event = event ?? "--"
        objTimeStamp.objectId = objectId ?? "--"
        objTimeStamp.lastSyncTime = lastSynch ?? "--"
        RealmManager().write(table: objTimeStamp)
        UtilPrintLogs.requestLogs(message:"Times stamp info", objectToPrint: RealmManager().readList(type: ModelTimesStampLog.self))
        //print(RealmManager().readList(type: ModelTimesStampLog.self))
    }
}

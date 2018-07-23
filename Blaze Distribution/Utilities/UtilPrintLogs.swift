//
//  UtilPrintLogs.swift
//  Blaze Distribution
//
//  Created by Apple on 17/07/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation
public enum DLogMessage : String{
    case InvoiceData = "Invoice Info"
    case POData = "Purchase Order Info"
    case InventryData = "Inventry Info"
    case ProductData = "Product Info"
    case Request = "Print Request"
    case Response = "Response Data"
    case Error = "Error"
}
public class UtilPrintLogs {
    public static let canPrintLog : Bool = true
    public static func DLog(message:String?, objectToPrint : Any?){
        if canPrintLog{
            if message == DLogMessage.Request.rawValue{
                print("-------------\(message ?? "")----------------")
                print(objectToPrint ?? "")
            }
//              print("-------------\(message ?? "")----------------")
//              print(objectToPrint ?? "")
        }
    }
}

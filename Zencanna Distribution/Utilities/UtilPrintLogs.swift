//
//  UtilPrintLogs.swift
//  shopperspick Distribution
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
    
    func  value() -> String{
            return self.rawValue
    }
}
public class UtilPrintLogs {
    private static let canPrintLog : Bool = false
    public static let canPrintRequestLog : Bool = true
    public static let canPrintResponseLog : Bool = true
    
    
    public static func DLog(message:String?, objectToPrint : Any?){
        if canPrintLog{
            print("-------------\(message ?? "")----------------")
            print(objectToPrint ?? "")
        }
    }
    
    public static func requestLogs(message:String?, objectToPrint : Any?){
        if canPrintRequestLog{
            if message == DLogMessage.Request.rawValue{
                print("-------------\(message ?? "")----------------")
                print(objectToPrint ?? "")
            }
        }
    }
    
    public static func responseLogs(message:String?, objectToPrint : Any?){
        if canPrintResponseLog{
                print("-------------\(message ?? "")----------------")
                print(objectToPrint ?? "")
        }
    }
}

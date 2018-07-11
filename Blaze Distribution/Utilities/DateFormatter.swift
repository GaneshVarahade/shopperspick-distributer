//
//  DateFormatter.swift
//  Blaze Distribution
//
//  Created by Apple on 13/06/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation


public class DateFormatterUtil {
    
    public static let yyyyMMddHHmm:String = "yyyy-MM-dd HH:mm"
    public static let mmddyyyy:String = "MM/dd/yyyy"
    public static let hhmma:String = "hh:mm a"
    
    public static func format(dateTime: Double, format:String) -> String{
        let date = Date(timeIntervalSince1970: dateTime)
        let nsDateFormatter = DateFormatter()
        
        //nsDateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        nsDateFormatter.locale = NSLocale.current
        nsDateFormatter.dateFormat = format
        return nsDateFormatter.string(from: date)
    }
    
    public static func formatStringToInt(dateTime: String, format:String) -> Int{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let dateFromString = dateFormatter.date(from: dateTime)
        let intDate = Int((dateFromString?.timeIntervalSince1970)!)
        return DateIntConvertUtil.convert(dateTime: intDate, type: DateIntConvertUtil.Miliseconds)
    }
}

extension Date {
    
    init(ticks: UInt64) {
        self.init(timeIntervalSince1970: Double(ticks)/10_000_000 - 62_135_596_800)
    }
    
    var ticks: UInt64 {
        return UInt64((self.timeIntervalSince1970 + 62_135_596_800) * 10_000_000)
    }
}

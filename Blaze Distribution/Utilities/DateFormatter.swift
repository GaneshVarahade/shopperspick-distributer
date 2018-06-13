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
    public static func format(dateTime: Double, format:String) -> String{
        print(dateTime)
        let date = Date(timeIntervalSince1970: dateTime)
        let nsDateFormatter = DateFormatter()
        
        //nsDateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        nsDateFormatter.locale = NSLocale.current
        nsDateFormatter.dateFormat = format
        return nsDateFormatter.string(from: date)
    }
}

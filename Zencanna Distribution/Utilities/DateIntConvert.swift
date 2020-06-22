//
//  DateIntConvert.swift
//  shopperspick Distribution
//
//  Created by Apple on 11/07/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation

public class DateIntConvertUtil {
    
    public static let Miliseconds:String = "Miliseconds"
    public static let Seconds:String = "Seconds"
    
    public static func convert(dateTime: Int, type:String) -> Int{
        var convertedDate : Int
        if type == Miliseconds{
            convertedDate = dateTime * 1000
        }else{
            convertedDate = dateTime / 1000
        }
        return convertedDate
    }
}


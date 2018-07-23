//
//  UtilityUserDefaults.swift
//  Blaze Distribution
//
//  Created by Apple on 04/06/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation

public class UtilityUserDefaults {
    
    public static let TOKEN:String = "TOKEN"
    private static var util:UtilityUserDefaults!
    private init(){}
    
    public static func sharedInstance() -> UtilityUserDefaults{
        if util == nil {
            util = UtilityUserDefaults()
        }
        return util
    }
    
    public func saveToken(strToken:String){
        UserDefaults.standard.set(strToken, forKey: UtilityUserDefaults.TOKEN)
        UserDefaults.standard.synchronize()
    }
    public func getToken() -> String?{
        return UserDefaults.standard.string(forKey: UtilityUserDefaults.TOKEN)
        
    }
}

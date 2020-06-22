//
//  VersionUtils.swift
//  shopperspick Distribution
//
//  Created by Apple on 07/06/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation

public class Versionutils {
    
    open class func getAppVersion() -> String {
        if let shortVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            return shortVersion
        }
        
        return ""
    }
    
    open class func getFullAppVersion() -> String {
        if let bVersion = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            if let shortVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
                return "v\(shortVersion) (build: \(bVersion))"
            }
        }
        return ""
    }
    
}

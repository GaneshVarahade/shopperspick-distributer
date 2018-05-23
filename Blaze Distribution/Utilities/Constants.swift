//
//  Constants.swift
//  Pyfe
//
//  Created by Sachin on 21/11/16.
//  Copyright © 2016 Sachin Kadam. All rights reserved.
//

import Foundation

struct Constants {
    
    struct GoogleMaps {
        static let GMSServiceAPIKey = "AIzaSyB8JmHSYfbbnYtOH-_951l-LMgU-WjpHCw"
    }
    
    struct Development {
        
        static let baseURL = "https://api.dev.blaze.me/api/v1/session/terminal/init"
        static let Content_Type = "application/json"
    }
    
    struct Production {
        
        static let baseURL = ""
    }
    
    struct WebAPI {
        
       static let DEFAULT_ERROR         = "Oops, something went wrong, please try again!"
       static let INVALID_AUTH_KEY      = "Your session has expired. please register again!"
       static let SERVICE_NOT_AVAILABLE = "Your internet connection appears to be super slow, bouncy or dead, please check!"
    }
}

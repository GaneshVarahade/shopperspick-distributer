//
//  SwiftExtentions.swift
//  Blaze Distribution
//
//  Created by Apple on 20/05/18.
//  Copyright © 2018 Fidel IT Services LLP. All rights reserved.
//

import Foundation
import UIKit
import KSToastView

extension Bundle {
    
    var releaseVersionNumber: String? {
        
        get{
            return infoDictionary?["CFBundleShortVersionString"] as? String
        }
    }
    
    var releaseBuildNumber: String? {
        
        get{
            return infoDictionary?["CFBundleVersion"] as? String
        }
    }
}

extension UIViewController {
    
    public func showToast(_ message: String? ) {
    
        KSToastView.ks_showToast(message)
        
    }
}

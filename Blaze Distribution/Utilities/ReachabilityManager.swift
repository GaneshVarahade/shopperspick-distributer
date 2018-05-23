//
//  ReachabilityManager.swift
//  GreenForceDelivery
//
//  Created by Fidel iOS on 06/02/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import UIKit
import Reachability
import KSToastView
import Alamofire
class ReachabilityManager: NSObject {
    
    static  let shared = ReachabilityManager()

    // 3. Boolean to track network reachability
    var isNetworkAvailable : Bool {
        return reachabilityStatus != .none
    }
    // 4. Tracks current NetworkStatus (notReachable, reachableViaWiFi, reachableViaWWAN)
    var reachabilityStatus: Reachability.Connection = .none
    // 5. Reachability instance for Network status monitoring
    let reachability = Reachability()!
    
    @objc func reachabilityChanged(notification: Notification) {
        let reachability = notification.object as! Reachability
        switch reachability.connection {
        case .none:
         
            
            showMessage(message:"Network became unreachable")
        case .wifi:
         
            
         
          
            showMessage(message:"Network reachable through WiFi")
        case .cellular:
         
         
          
            
            showMessage(message:"Network reachable through Cellular Data")
            
        }
    }
    
    /// Starts monitoring the network availability status
    func startMonitoring() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.reachabilityChanged),
                                               name: Notification.Name.reachabilityChanged,
                                               object: reachability)
        do{
            try reachability.startNotifier()
        } catch {
           print("Could not start reachability notifier")
        }
    }
    
    func showMessage(message:String){
        
        KSToastView.ks_showToast(message, delay: 1.2)
    }
  func networkStatus() -> Bool{
        
        if let status = Alamofire.NetworkReachabilityManager(){
            
            return status.isReachable
            
        } else if let status = Alamofire.NetworkReachabilityManager(){
            
            return status.isReachableOnEthernetOrWiFi
            
        } else {
            
            return false
        }
    
    }
    
}

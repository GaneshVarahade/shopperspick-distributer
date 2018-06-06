//
//  SyncService.swift
//  Blaze Distribution
//
//  Created by Apple on 06/06/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import Foundation

public final class SyncService {
    
    private var queue : DispatchQueue = DispatchQueue(label: "com.blaze.distribution.Blaze-Distribution")
    private static var syncService: SyncService!
    
    private init(){}
    public static func sharedInstance() -> SyncService {
        
        if syncService == nil {
            syncService = SyncService()
        }
        
        return syncService
    }
    
    private var isUpdating:Bool = false
    
    
    public func syncData() {
        
        ///Synchronized block for multithreaded environment
        queue.sync {
            
            /// If Data is already syncing, then return from here
            guard !isUpdating else{
                return
            }
            
            /// If network is not available then return
            guard ReachabilityManager.shared.networkStatus() else {
                return
            }
            isUpdating = true
        }
        
        if isSignatureAvailable() {
            
            syncSignature()
            
        }else if isPostBulkAvailable() {
            
            syncPostBulkData()
            
        }else{
            syncGetBulkData()
        }
        
    }
    
    private func isSignatureAvailable() -> Bool {
        
        return false
    }
    
    private func isPostBulkAvailable() -> Bool {
        
        return false
    }
    
    private func syncSignature() {
        
        ///After API complete call resync
    }
 
    private func syncPostBulkData(){
        
        ///After API complete call resync
    }
    
    private func syncGetBulkData() {
        
    }
    
     private func resync() {
        isUpdating = false
        syncData()
    }
}

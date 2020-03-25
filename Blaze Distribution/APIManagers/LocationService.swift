//
//  LocationService.swift
//  Dispensary
//
//  Created by Apple on 25/02/20.
//  Copyright © 2020 420connect. All rights reserved.
//

import Foundation
import CoreLocation
import RealmSwift
import SKActivityIndicatorView

let instance = LocationService()

class LocationService: NSObject, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    var available = false
    var internalServer = true
    var viewController:UIViewController? = nil
    var isChecked = false
    
    static func sharedInstance() -> LocationService{
        return instance
    }
    
    func subscribeViewController(_ viewController:UIViewController)
    {
        self.viewController = viewController
    }
    
    func setLocationPermission(){
        if !internalServer{
        locationManager.delegate = self
        if !isLocationEnabled(){
            if isLocationDenied()
            {
                showLocationAlert()
            }else{
                locationManager.requestAlwaysAuthorization()
            }
        }else{
            locationManager.requestLocation()
            if let location = locationManager.location{
                checkForLocation(location)
            }
        }
        }
    }
    
    func showLocationAlert()
    {
        let alertController = UIAlertController(title: "Location Permission", message: "Please allow Zencanna to access location permission by modifying settings to 'Always'", preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        {
            _ in
            self.showImportantDialog()
        }
        
        let allow = UIAlertAction(title: "Allow", style: .default){
            _ in
            if let url = NSURL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            }
        }
        
        alertController.addAction(cancel)
        alertController.addAction(allow)
        
        viewController?.present(alertController, animated: true, completion: nil)
    }
    
    func showImportantDialog()
    {
        let alertController = UIAlertController(title: "Why we use location?", message: "Zencanna uses location to identity regions where Cannabis is legal", preferredStyle: .alert)
        
        let okay = UIAlertAction(title: "Okay", style: .cancel){
            _ in
            self.showLocationAlert()
        }
        
        alertController.addAction(okay)
        
        viewController?.present(alertController, animated: true, completion: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if !internalServer{
        if isLocationEnabled(){
            manager.startUpdatingLocation()
        }else{
            setLocationPermission()
        }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !internalServer{
        if let location = manager.location{
            manager.stopUpdatingLocation()
            checkForLocation(location)
        }
        }
    }
    
    func isLocationEnabled() -> Bool{
        return CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
        CLLocationManager.authorizationStatus() == .authorizedAlways
    }
    
    func isLocationDenied() -> Bool{
        return CLLocationManager.authorizationStatus() == .denied
    }
    
    func navigateToUnavailableVC(_ isNetworkReachable:Bool){
        if let viewController = viewController{
        let vc = viewController.storyboard?.instantiateViewController(withIdentifier: "FTUnavailableScreenViewController") as! FTUnavailableScreenViewController
            vc.isNetworkReachable = isNetworkReachable
        viewController.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func checkForLocation(_ location: CLLocation?){
        if !internalServer{
        if isChecked{
            if let state = getObject()
            {
                if let available = state.available, !available{
                    self.navigateToUnavailableVC(true)
                    return
                }
            }
        }
        
        if !ReachabilityManager.shared.networkStatus(){
            navigateToUnavailableVC(false)
            return
        }
        
        var loc = location
        if location == nil{
            loc = locationManager.location
        }
        
        if let location = loc{
        
        let geoCoder = CLGeocoder.init()
        geoCoder.reverseGeocodeLocation(location){
            placemarks, errors in
            
            if errors == nil{
                for placemark in placemarks ?? []{
                    if let state = placemark.administrativeArea{
                        
                        if placemark.country != "United States"
                        {
                            self.navigateToUnavailableVC(true)
                            return
                        }
                        
                        let request = LocationDataRequest()
                        request.state = state
                        SKActivityIndicator.show("Communicating With Server")
                        WebServicesAPI.sharedInstance().getAppLocationPermissions(request: request){
                            response, error in
                            Router.baseURLString = DistributionConfig.sharedInstance().getAppUrl()
                            SKActivityIndicator.dismiss()
                            
                            self.removeObjects()
                            
                            if error != nil || !response!.available!{
                                self.navigateToUnavailableVC(true)
                                return
                            }
                            
                            if let locationResponse = response{
                                self.isChecked = true
                                let realm = try! Realm(configuration: Realm.Configuration(schemaVersion: 1))
                                try! realm.write ({
                                    realm.add(locationResponse, update: .all)
                                })
                            }
                         }
                        break
                    }
                }
            }
        }
        }
        }
    }
    
    func getCurrentState() -> String?{
        if let state = getObject(){
        return state.state
        }
        return nil
    }
    
    private func getObject() -> LocationDataResponse?{
        let realm = try! Realm()
        let states = realm.objects(LocationDataResponse.self)
        if states.count > 0{
            return states[0]
        }
        return nil
    }
    
    func getAvailable() -> Bool{
        if internalServer{
            return true
        }
        if let state = getObject(){
            return state.available ?? false
        }
        return false
    }
    
    func removeObjects(){
        let realm = try! Realm(configuration: Realm.Configuration(schemaVersion: 1))
        try! realm.write {
            realm.delete(realm.objects(LocationDataResponse.self))
        }
    }
    
}

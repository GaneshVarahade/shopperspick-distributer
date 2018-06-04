//
//  WebServicesAPI.swift
//  GreenForceDelivery
//
//  Created by Fidel iOS on 08/02/18.
//  Copyright © 2018 Fidel iOS. All rights reserved.
//

import UIKit
import Alamofire
import Foundation
import Realm
import RealmSwift

class WebServicesAPI: NSObject {
    
    static let singleToneObject = WebServicesAPI()
    private override init(){
    }
    // MARK: -  Login API
    func login(user_Name:String,password:String,onComplition:@escaping (String)->Void){
        var data:ModelLogin!
        let url = "https://api.dev.blaze.me/api/v1/session/terminal/init"
        print("URL:",url)
        let header:HTTPHeaders = ["Content-Type":Constants.Development.Content_Type]
        let parametrs:Parameters = ["email"          :user_Name,
                                    "password"       :password,
                                    "version"        :"2.10.10",
                                    "deviceId"       :"1F036D8E-1EE4-4C1C-B451-0EA44760344F"]
        print("Parameter",parametrs)
        Alamofire.request(url, method: .post, parameters: parametrs, encoding: JSONEncoding.default, headers: header).responseJSON(completionHandler:{ response in
            switch response.result{
            case .success:
                
                if response.response?.statusCode == 200{
                
                do{
                    data = try JSONDecoder().decode(ModelLogin.self, from:response.data!)
                    let realm = try! Realm()
                    try! realm.write {
                        
                        realm.add((data)!)
                        
                        onComplition("true")
                        
                    }
                    
                    
                }catch{
                    print(error)
                }
    
                   
                }else if response.response?.statusCode == 400{
                    
                    print("Bad request ...")
                    
                }else if response.response?.statusCode == 401{
                    
                    print("Unauthorized user ...")
                    
                }else{
                    
                    print("Server error ....")
                    
                }
                 
                    
                    
                //onComplition(jsonData,"",code!)
                break
            case .failure(let error):
                print(error)
                //onComplition(JSON.null,error.localizedDescription,0)
                break
            }
        })
        
    }
    
}



    


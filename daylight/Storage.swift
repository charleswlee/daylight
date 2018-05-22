//
//  Storage.swift
//  daylight
//
//  Created by Charles Lee on 5/21/18.
//  Copyright © 2018 Charles Lee. All rights reserved.
//

import UIKit

class Storage {
    
    class func saveData(dataObj : [String:Any]) {
        UserDefaults.standard.set(dataObj, forKey: "daylight")
        UserDefaults.standard.synchronize()
    }
    
    class func getData() -> ([String:Any]?) {
        if let data = UserDefaults.standard.dictionary(forKey: "daylight"){
            return data
        }
        return nil
    }
    
    class func isGPSEnabled() -> (Bool) {
        return UserDefaults.standard.bool(forKey: "gps")
    }
    
    class func setGPSState(enabled: Bool) {
        UserDefaults.standard.set(enabled, forKey: "gps")
        UserDefaults.standard.synchronize()
    }
    
    class func isNotFirstRun() -> (Bool) {
        return UserDefaults.standard.bool(forKey: "not_first_run")
    }
    
    class func setIsNotFirstRun() {
        UserDefaults.standard.set(true, forKey: "not_first_run")
    }
    
    class func getZipCode() -> (String?) {
        if let zip = UserDefaults.standard.string(forKey: "zip") {
            return zip
        }
        return nil
    }
    
    class func setZipCode(zip: String) {
        UserDefaults.standard.set(zip, forKey: "zip")
        UserDefaults.standard.synchronize()
    }
    
}

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
    
}

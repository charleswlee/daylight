//
//  APICalls.swift
//  daylight
//
//  Created by Charles Lee on 5/21/18.
//  Copyright © 2018 Charles Lee. All rights reserved.
//

import UIKit

class APICalls {
    
    // Call API to get the sunrise and sunset info
    class func getSunriseSunsetForLat(_ lat: String, long: String, date: String, result: @escaping (_ succes: Bool, _ jsonresult:[String: Any]?) -> Void) {
        
        let stringURL = "https://api.sunrise-sunset.org/json?lat="+lat+"&lng="+long+"&date="+date+"&formatted=0"
  
        let url = URL(string:stringURL )
        let session = URLSession.shared
        let task = session.dataTask(with: url!, completionHandler: { (data, response, error) in
            do {
                if let data = data,
                    let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                    let results = json["results"] as? [String: Any],
                    let status = json["status"] as? String {
                    if( status == "OK") {
                        result(true,results)
                    } else {
                        result(false,nil)
                    }
                } else {
                    result(false,nil)
                }
            } catch {
                print("Error deserializing JSON: \(error)")
                result(false,nil)
            }
        })
        task.resume()
    }
}

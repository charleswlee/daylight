//
//  Zip2LatLong.swift
//  daylight
//
//  Created by Charles Lee on 5/22/18.
//  Copyright © 2018 Charles Lee. All rights reserved.
//

import UIKit

class Zip2LatLong {
    class func getLatLongForZip(zip: String) -> (String?,String?)
    {
        if let filePath = Bundle.main.path(forResource: "zipcodes", ofType: "json"), let data = NSData(contentsOfFile: filePath) {
            do {
                let json :  [String: Any] = (try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any])!
                if let latlong = json[zip] as? [String:Any],
                    let lat =  latlong["LAT"] as? Double,
                    let long = latlong["LNG"] as? Double {
                    return (String(lat),String(long))
                }
            }
            catch {
                print("Error getting Lat Long for zip")
            }
        }
        return (nil,nil)
    }}

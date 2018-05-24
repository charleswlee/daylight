//
//  Zip2LatLong.swift
//  daylight
//
//  Created by Charles Lee on 5/22/18.
//  Copyright © 2018 Charles Lee. All rights reserved.
//

import UIKit

class Zip2LatLong {
    
    // Lookup zip code and return lat long if it is in the list
    class func getLatLongForZip(zip: String) -> (String?,String?)
    {
        if let filePath = Bundle.main.path(forResource: "zipcodes", ofType: "json"), let data = NSData(contentsOfFile: filePath) {
            do {
                let json = try JSONSerialization.jsonObject(with: data as Data) as? [String: Any]
                if let latlong = json![zip] as? [String:Any],
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

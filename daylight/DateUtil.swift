//
//  DateUtil.swift
//  daylight
//
//  Created by Charles Lee on 5/21/18.
//  Copyright © 2018 Charles Lee. All rights reserved.
//

import UIKit

class DateUtil {
    
    // We need to convert the dates from ISO8601 format to just a hh:mm a for display
    class func convertUTC2TimeWithDate(string: String) -> String {
        let isoDateFormat = ISO8601DateFormatter()
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        
        let parsedDate = isoDateFormat.date(from: string)
        return formatter.string(from: parsedDate!)
    }
    
}

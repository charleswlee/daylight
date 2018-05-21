//
//  DateUtil.swift
//  daylight
//
//  Created by Charles Lee on 5/21/18.
//  Copyright © 2018 Charles Lee. All rights reserved.
//

import UIKit

class DateUtil {
    
    class func convertUTC2TimeWithDate(string: String) -> String {
        let isoDateFormat = ISO8601DateFormatter()
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        
        let parsedDate = isoDateFormat.date(from: string)
        return formatter.string(from: parsedDate!)
    }
    
}

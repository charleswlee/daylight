//
//  DetailTableViewController.swift
//  daylight
//
//  Created by Charles Lee on 5/21/18.
//  Copyright © 2018 Charles Lee. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
    
    @IBOutlet weak var sunrise: UILabel!
    @IBOutlet weak var sunset: UILabel!
    @IBOutlet weak var solar: UILabel!
    @IBOutlet weak var length: UILabel!
    @IBOutlet weak var civilTwilight: UILabel!
    @IBOutlet weak var civilTwilightEnd: UILabel!
    @IBOutlet weak var nauticalTwilight: UILabel!
    @IBOutlet weak var nauticalTwilightEnd: UILabel!
    @IBOutlet weak var astTwilight: UILabel!
    @IBOutlet weak var astTwilightEnd: UILabel!
    
    var data : [String:Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = UITableViewAutomaticDimension

        if ((data) != nil) {
            self.sunrise.text = DateUtil.convertUTC2TimeWithDate(string:self.data!["sunrise"] as! String)
            self.sunset.text = DateUtil.convertUTC2TimeWithDate(string:self.data!["sunset"] as! String)
            self.solar.text = DateUtil.convertUTC2TimeWithDate(string:self.data!["solar_noon"] as! String)
            self.civilTwilight.text = DateUtil.convertUTC2TimeWithDate(string:self.data!["civil_twilight_begin"] as! String)
            self.civilTwilightEnd.text = DateUtil.convertUTC2TimeWithDate(string:self.data!["civil_twilight_end"] as! String)
            self.astTwilight.text = DateUtil.convertUTC2TimeWithDate(string:self.data!["astronomical_twilight_begin"] as! String)
            self.astTwilightEnd.text = DateUtil.convertUTC2TimeWithDate(string:self.data!["astronomical_twilight_end"] as! String)
            self.nauticalTwilight.text = DateUtil.convertUTC2TimeWithDate(string:self.data!["nautical_twilight_begin"] as! String)
            self.nauticalTwilightEnd.text = DateUtil.convertUTC2TimeWithDate(string:self.data!["nautical_twilight_end"] as! String)
            
            // Convert day length from seconds to hh:mm:ss with padded zeros for single digits
            if let len = self.data!["day_length"] as? Int {
                let hours = len / 3600
                let minutes = (len - (3600 * hours))/60
                let seconds = (len - (3600 * hours)) % 60
                self.length.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//
//  ViewController.swift
//  daylight
//
//  Created by Charles Lee on 5/21/18.
//  Copyright © 2018 Charles Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let loc : Location = Location()
    
    @IBOutlet weak var sunriseLabel: UILabel!

    @IBOutlet weak var sunsetLabel: UILabel!
    
    var data : [String:Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let savedData = Storage.getData() {
            self.data = savedData
            self.loadData()
        }
        
        loc.locationAcquired = {
            (lat,long) -> Void in
            API.getSunriseSunsetForLat(lat, long: long) { (success, resultObject) in
                if(success) {
                    Storage.saveData(dataObj: resultObject!)
                    self.data = resultObject
                    self.loadData()
                } else {
                    print("Failed to get data!")
                }
            }
        }
        loc.getLocation()
    }
    
    func loadData() {
        // This code CAN be called from a background thread so we need to be sure its on main
        DispatchQueue.main.async{
            let sunrise = DateUtil.convertUTC2TimeWithDate(string: self.data!["sunrise"] as! String)
            let sunset = DateUtil.convertUTC2TimeWithDate(string: self.data!["sunset"] as! String)
        
            self.sunriseLabel.text = sunrise
            self.sunsetLabel.text = sunset
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "detail") {
            if let detail = segue.destination as? DetailTableViewController {
                detail.data = self.data
            }
        }
    }
    
}


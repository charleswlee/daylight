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
            
            if let len = self.data!["day_length"] as? Int {
                let hours = len / 3600
                let minutes = (len - (3600 * hours))/60
                let seconds = (len - (3600 * hours)) % 60
                self.length.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
            }
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
/*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

 */
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

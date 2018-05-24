//
//  SettingsTableViewController.swift
//  daylight
//
//  Created by Charles Lee on 5/22/18.
//  Copyright © 2018 Charles Lee. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    @IBOutlet weak var gpsSwitch: UISwitch!
    
    @IBOutlet weak var zipTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gpsSwitch.addTarget(self, action: #selector(switchChanged), for: UIControlEvents.valueChanged)
        
        gpsSwitch.isOn = Storage.isGPSEnabled()
        zipTextField.text = Storage.getZipCode()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if(!Storage.isGPSEnabled()) {
            if(self.zipTextField.text?.count == 5) {
                let (lat,long) = Zip2LatLong.getLatLongForZip(zip: self.zipTextField.text!)
                if (lat != nil && long != nil) {
                    Storage.setZipCode(zip: self.zipTextField.text!)
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // if GPS is enabled hide the zip code field
        if (Storage.isGPSEnabled()) {
            return 1
        } else {
            return 2
        }
    }
    
    @objc func switchChanged(s: UISwitch) {
        let on = s.isOn
        Storage.setGPSState(enabled: on)
        
        // update the table when the switch is flipped 
        tableView.reloadData()
    }
    

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

extension SettingsTableViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {

    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // allow empty
        if (string.isEmpty) {
            return true
        }
        
        // don't allow over 5 charactors
        if (range.location > 4) {
            return false
        }
        
        // only allow numbers
        if (textField == self.zipTextField) {
            let cs = NSCharacterSet(charactersIn: "0123456789")
            let filtered = string.components(separatedBy: cs as CharacterSet).filter {  !$0.isEmpty }
            let str = filtered.joined(separator: "")
            
            return (string != str)
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true
    }
}

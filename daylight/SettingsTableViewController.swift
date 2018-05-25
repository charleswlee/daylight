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
        
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(SettingsTableViewController.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        zipTextField.inputAccessoryView = toolBar
        
        gpsSwitch.addTarget(self, action: #selector(switchChanged), for: UIControlEvents.valueChanged)
        
        gpsSwitch.isOn = Storage.isGPSEnabled()
        zipTextField.text = Storage.getZipCode()
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
    
    @objc func doneClick() {
        zipTextField.resignFirstResponder()
    }
}

extension SettingsTableViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
            return false
        }
        
        let newLength = (self.zipTextField.text?.utf16.count)! + string.utf16.count - range.length
        return newLength <= 5 
    }
}

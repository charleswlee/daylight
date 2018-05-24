//
//  DaylightViewController.swift
//  daylight
//
//  Created by Charles Lee on 5/21/18.
//  Copyright © 2018 Charles Lee. All rights reserved.
//

import UIKit

class DaylightViewController: UIViewController {
    
    var loc : Location?
    
    var datePicker : UIDatePicker!
    
    @IBOutlet weak var sunriseLabel: UILabel!

    @IBOutlet weak var sunsetLabel: UILabel!
    
    @IBOutlet weak var dateTextField: UITextField!
    
    var data : [String:Any]?
    
    var date : Date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        // Always load the current date
        
        self.setDate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Load dat when view has displayed to the user
        if(Storage.isNotFirstRun()) {
            
            if let savedData = Storage.getData() {
                self.data = savedData
                self.loadData()
            }
            
            self.updateSunriseSunset()
            
        } else {
            self.performSegue(withIdentifier: "setup", sender: self)
        }
    }
    
    func updateSunriseSunset() {
        if(Storage.isGPSEnabled()) {
            self.getSunriseSunsetWithGPS()
        } else {
            self.getSunriseSunsetWithZip()
        }
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
    
    func getDataFor(lat: String, long: String) {
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        let dateForAPI = dateFormat.string(from: self.date)

        APICalls.getSunriseSunsetForLat(lat, long: long,date:dateForAPI) { (success, resultObject) in
            if(success) {
                Storage.saveData(dataObj: resultObject!)
                self.data = resultObject
                self.loadData()
            } else {
                print("Failed to get data!")
            }
        }
    }
    
    func getSunriseSunsetWithGPS() {
        self.loc = Location()
        loc?.locationAcquired = {
            (lat,long) -> Void in
            self.getDataFor(lat: lat,long: long)
        }
        loc?.getLocation()
    }
    
    func getSunriseSunsetWithZip(){
        if let zip = Storage.getZipCode() {
            let (lat,long) = Zip2LatLong.getLatLongForZip(zip: zip)
            if(lat != nil && long != nil) {
                self.getDataFor(lat: lat!,long: long!)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Send data to show more complete details from the API call 
        if(segue.identifier == "detail") {
            if let detail = segue.destination as? DetailTableViewController {
                detail.data = self.data
            }
        }
    }

    func pickerDate(_ textField : UITextField){
        self.datePicker = UIDatePicker()
        self.datePicker.datePickerMode = UIDatePickerMode.date
        textField.inputView = self.datePicker
        
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(DaylightViewController.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(DaylightViewController.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
    }
    
    @objc func doneClick() {
        self.date = self.datePicker.date
        self.setDate()
        dateTextField.resignFirstResponder()
        self.updateSunriseSunset()
    }
    
    @objc func cancelClick() {
        dateTextField.resignFirstResponder()
    }
    
    func setDate() {
        let dateFormat = DateFormatter()
        dateFormat.dateStyle = .medium
        dateFormat.timeStyle = .none
        dateTextField.text = dateFormat.string(from: self.date)
    }
}

extension DaylightViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.pickerDate(self.dateTextField)
    }
}


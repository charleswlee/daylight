//
//  SetupViewController.swift
//  daylight
//
//  Created by Charles Lee on 5/22/18.
//  Copyright © 2018 Charles Lee. All rights reserved.
//

import UIKit

class SetupViewController: UIViewController {

    @IBOutlet weak var zipTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(SetupViewController.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        zipTextField.inputAccessoryView = toolBar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func useGPSAction(_ sender: UIButton) {
        Storage.setIsNotFirstRun()
        Storage.setGPSState(enabled: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func zipcodeGoAction(_ sender: UIButton) {
        let (lat,long) = Zip2LatLong.getLatLongForZip(zip: self.zipTextField.text!)
        if (lat != nil && long != nil) {
            Storage.setIsNotFirstRun()
            Storage.setZipCode(zip: self.zipTextField.text!)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func doneClick() {
        zipTextField.resignFirstResponder()
    }
}

extension SetupViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
            return false
        }
        
        let newLength = (self.zipTextField.text?.utf16.count)! + string.utf16.count - range.length
        return newLength <= 5
    }
}

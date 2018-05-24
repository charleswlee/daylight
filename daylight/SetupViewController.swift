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

        // Do any additional setup after loading the view.
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SetupViewController: UITextFieldDelegate {
    
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

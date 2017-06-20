//
//  SecondViewController.swift
//  MoneyChangerApp
//
//  Created by Iggy on 6/20/17.
//  Copyright © 2017 iggym. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController,  UIPickerViewDataSource, UIPickerViewDelegate , UITextFieldDelegate {

    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var secondImage: UIImageView!
    
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    var pickOption = [String]()
    
    var firstTextFieldSelected = false
    var secondTextFieldSelected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pickerView.isHidden = true
        //firstTextField.text = pickOption[0]
        firstTextField.delegate = self
        secondTextField.delegate = self
        pickerView.delegate = self
        pickOption = getCountries()
        firstImage.image = UIImage(named: "US")
        secondImage.image = UIImage(named: "MX")
    }
    
    func getCountries() -> [String]{
        var countries: [String] = []
        
        for code in NSLocale.isoCountryCodes as [String] {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            
            let name = NSLocale(localeIdentifier: "en_UK").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
            
            
            let all = "\(code) \(name)"
            print(all)
            
            countries.append(all)
        }
        return countries

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // returns the # of rows in each component..
    @available(iOS 2.0, *)
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickOption.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickOption[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedOption = pickOption[row]
        let code = String(selectedOption.characters.prefix(2))
        pickerView.isHidden = true;
       
        if firstTextFieldSelected {
            firstTextField.text = "\(selectedOption)"
            firstImage.image = UIImage(named: code)
        } else if secondTextFieldSelected {
            secondTextField.text = "\(selectedOption)"
            secondImage.image = UIImage(named: code)
        }
     
    }
    
    func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int)
    {
        if firstTextFieldSelected {
            firstTextField.text = pickOption[row]
        } else if secondTextFieldSelected {
             secondTextField.text = pickOption[row]
        }
        pickerView.isHidden = true;
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool   {
        if textField == firstTextField {
            firstTextFieldSelected = true
            secondTextFieldSelected = false
        } else if textField == secondTextField {
            secondTextFieldSelected = true
            firstTextFieldSelected = false
        }
        pickerView.isHidden = false
        return false
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

extension String {
    
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound - r.lowerBound)
        return self[Range(start ..< end)]
    }
}

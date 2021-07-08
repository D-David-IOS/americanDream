//
//  DollarViewController.swift
//  americanDream
//
//  Created by Debehogne David on 23/06/2021.
//

import UIKit

class DollarViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    // the user can select in the pickerview his local money
    @IBOutlet weak var ratePickerView: UIPickerView!
    
    // here the user enters his money ( ex : 1000.26 )
    @IBOutlet weak var LocalDeviseTextField: UITextField!
    
    // this response will appear when user validate
    @IBOutlet weak var responseLabel: UILabel!
    
    // Validate Button
    @IBOutlet weak var validateButton: UIButton!
    
    // Appears when user tap validate
    @IBOutlet weak var activityLoading: UIActivityIndicatorView!
    
    
    // an instance of DollarService
    let dollar = DollarService(session : URLSession(configuration: .default))
    
    // our pickerView has one column
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // our pickerView has rates.count elements
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return rates.count
    }
    
    // inform the view the current element selected
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return rates[row]
    }
    
    // textField is no longer the first responder
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // by default "EUR" is selected in the pickView
    override func viewDidLoad() {
        super.viewDidLoad()
        activityLoading.isHidden = true
        validateButton.layer.cornerRadius = 30
        ratePickerView.selectRow(46, inComponent: 0, animated: true)
        
    }
    
    // add a tapGestureRecogniser to the view
    // the user can hide the keyboard with a tap everywhere
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        LocalDeviseTextField.resignFirstResponder()
    }
    
    // When user Validates
    // convert his current money into USD money
    @IBAction func tappedButton(_ sender: Any) {
        activityLoading.isHidden = false
        validateButton.isHidden = true
  
        dollar.getDollar() { succes, dollar in
      
            guard succes, let dollar = dollar else {
                self.presentAlert(with: "la requête à échoué")
                return
            }
            
            let localDevise = self.LocalDeviseTextField.text
            let moneyIndex = self.ratePickerView.selectedRow(inComponent: 0)
            let money = rates[moneyIndex]
            
            // here we try to convert the money in a Double
            // if the user enter an invalide number, present an alert to the user
            guard let result = Double(localDevise!) else {
                self.presentAlert(with: "Veuillez entrer un nombre valide")
                self.activityLoading.isHidden = true
                self.validateButton.isHidden = false
                return
            }
            
            let convertion = dollar.convertionIntoDollar(number : result, local : money, dict : dollar.rates as NSDictionary)
            
            self.responseLabel.text = "\(result) \(money) vaut actuellement \(Double(round(100*(convertion))/100))$ !"

            self.activityLoading.isHidden = true
            self.validateButton.isHidden = false
        }
    }
    
    
}

// create a simple alert with presentAlert(with error : "text here")
extension DollarViewController {
    // create an alert, the parameter "with error" is the error message
    private func presentAlert(with error: String){
        let alertVC = UIAlertController(title: "Erreur", message: error, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertVC.addAction(action)
        present(alertVC, animated: true, completion: nil)
    }
}

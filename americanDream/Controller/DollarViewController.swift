//
//  DollarViewController.swift
//  americanDream
//
//  Created by Debehogne David on 23/06/2021.
//

import UIKit

class DollarViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var ratePickerView: UIPickerView!
    
    @IBOutlet weak var LocalDeviseTextField: UITextField!
    
    @IBOutlet weak var responseLabel: UILabel!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return rates.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return rates[row]
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ratePickerView.selectRow(46, inComponent: 0, animated: true)
        
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        LocalDeviseTextField.resignFirstResponder()
    }
    
    
    @IBAction func tappedButton(_ sender: Any) {
        DollarService.getDollar() { succes, dollar in
            if succes, let dollar = dollar {
                
                let localDevise = self.LocalDeviseTextField.text
                let moneyIndex = self.ratePickerView.selectedRow(inComponent: 0)
                let money = rates[moneyIndex]
                
                print(localDevise!)
                print(money)
                
                
                guard   let result = Double(localDevise!) else {
                    self.presentAlert(with: "Veuillez entrer un nombre valide")
                    return
                }
                
                let abc = dollar.convertionIntoDollar(number : result, local : money, dict : dollar.rates as NSDictionary)
                
                self.responseLabel.text = "\(result) \(money) vaut actuellement \(Double(round(100*(abc))/100))$ !"
                
            }
            else {
                self.presentAlert(with: "erreur de décodage")
            }
        }
    }
    
    
    private func presentAlert(with error: String){
        let alertVC = UIAlertController(title: "Erreur", message: error, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertVC.addAction(action)
        present(alertVC, animated: true, completion: nil)
    }
}

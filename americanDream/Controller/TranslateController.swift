//
//  TranslateController.swift
//  americanDream
//
//  Created by Debehogne David on 26/06/2021.
//

import UIKit

class TranslateController: UIViewController {
    
    // the user enter a text, this one will be translate
    @IBOutlet weak var text: UITextField!
    // the text translated
    @IBOutlet weak var traductionText: UILabel!
    
    // an instance of TranslateService
    let traduction = TranslateService(session : URLSession(configuration: .default))
    
    // add a tapGestureRecogniser to the view
    // the user can hide the keyboard with a tap everywhere
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        text.resignFirstResponder()
    }
    
    // When user Validates
    // convert the text in english
    @IBAction func tappedTranslate(_ sender: Any) {

        let encodedString = text.text!.addingPercentEncoding(withAllowedCharacters: CharacterSet(charactersIn: "<>!*();^:@&=+$,|/?%#[]{}~’\" ").inverted)
        
        traduction.getTranslate(request: traduction.createDollarRequest(sentence: encodedString!)) { succes, translate in
            guard succes, let translate = translate else {
                self.presentAlert(with: "la requête à échouée")
                return
            }
            self.traductionText.text = translate.returnTranslate()
        }
    }
}

extension TranslateController {
    // create an alert, the parameter "with error" is the error message
    private func presentAlert(with error: String){
        let alertVC = UIAlertController(title: "Erreur", message: error, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertVC.addAction(action)
        present(alertVC, animated: true, completion: nil)
    }
}

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

    // appeas when user push "Translate"
    @IBOutlet weak var activityLoading: UIActivityIndicatorView!
    
    // the button Translate
    @IBOutlet weak var TranslateButton: UIButton!
    
    // an instance of TranslateService
    let traduction = TranslateService(session : URLSession(configuration: .default))
    
    // add a tapGestureRecogniser to the view
    // the user can hide the keyboard with a tap everywhere
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        text.resignFirstResponder()
    }

    override func viewDidLoad() {
        activityLoading.isHidden = true
        TranslateButton.layer.cornerRadius = 30
    }
    
    // When user Validates
    // convert the text in english
    @IBAction func tappedTranslate(_ sender: Any) {
        activityLoading.isHidden = false
        TranslateButton.isHidden = true

        // we have to encore all this characters else the request fail
        let encodedString = text.text!.addingPercentEncoding(withAllowedCharacters: CharacterSet(charactersIn: "<>!*();^:@&=+$,|/?%#[]{}~’\" ").inverted)
        
        // ask to api google translate to return the text translated
        traduction.getTranslate(request: traduction.createDollarRequest(sentence: encodedString!)) { succes, translate in
            guard succes, let translate = translate else {
                self.presentAlert(with: "la requête à échouée")
                self.activityLoading.isHidden = true
                self.TranslateButton.isHidden = false
                return
            }
            self.traductionText.text = translate.returnTranslate()
            self.activityLoading.isHidden = true
            self.TranslateButton.isHidden = false
        }
    }
}


// create a simple alert with presentAlert(with error : "text here")
extension TranslateController {
    // create an alert, the parameter "with error" is the error message
    private func presentAlert(with error: String){
        let alertVC = UIAlertController(title: "Erreur", message: error, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertVC.addAction(action)
        present(alertVC, animated: true, completion: nil)
    }
}

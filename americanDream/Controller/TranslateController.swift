//
//  TranslateController.swift
//  americanDream
//
//  Created by Debehogne David on 26/06/2021.
//

import UIKit

class TranslateController: UIViewController {
    
    @IBOutlet weak var frenchText: UITextField!
    @IBOutlet weak var traductionText: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        frenchText.resignFirstResponder()
    }
    
    @IBAction func tappedTranslate(_ sender: Any) {
        var sentence = frenchText.text!.replacingOccurrences(of: " ", with: "+")
        sentence = sentence.replacingOccurrences(of: "’", with: "'")
        print(sentence)
        TraductionService.getTranslate(sentence : sentence) { succes, translate in
                if succes, let translate = translate {
                    print(translate.returnTranslate())
                    self.traductionText.text = translate.returnTranslate()
                }
                else {
                    print("error")
                }
            }
        
    }

}

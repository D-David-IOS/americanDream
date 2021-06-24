//
//  DollarViewController.swift
//  americanDream
//
//  Created by Debehogne David on 23/06/2021.
//

import UIKit

class DollarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func tappedButton(_ sender: Any) {
        DollarService.getDollar()
    }
    
}

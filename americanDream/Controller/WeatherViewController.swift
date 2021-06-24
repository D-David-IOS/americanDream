//
//  WeatherViewController.swift
//  americanDream
//
//  Created by Debehogne David on 22/06/2021.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func viewDidLoad() {
        WeatherService.getWeather { succes, weather in
            if succes, let weather = weather {
                self.descriptionLabel.text = weather.idConditions(id: weather.id)[1]
                self.temperatureLabel.text = String(weather.temp)
                self.ImageView.image = UIImage(data: weather.imageData)
            }
            else {
                print("error")
            }
        }
    }
        override func viewWillAppear(_ animated: Bool) {
        
    }
    
    @IBAction func tappedButton(_ sender: Any) {
        
    }
}

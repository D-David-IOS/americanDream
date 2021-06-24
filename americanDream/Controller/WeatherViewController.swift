//
//  WeatherViewController.swift
//  americanDream
//
//  Created by Debehogne David on 22/06/2021.
//

import UIKit

class WeatherViewController: UIViewController {

    
    // New York city
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var villeLabel: UILabel!
    
    // Maubeuge city
    @IBOutlet weak var maubeugeLabel: UILabel!
    @IBOutlet weak var maubeugeTempLabel: UILabel!
    @IBOutlet weak var maubeugeImageLabel: UIImageView!
    @IBOutlet weak var maubeugeDescription: UILabel!
    
    
    override func viewDidLoad() {
        WeatherService.getWeather(city : "New+York") { succes, weather in
            if succes, let weather = weather {
                self.descriptionLabel.text = weather.idConditions(id: weather.id)
                self.temperatureLabel.text = "ici il fait \(String(weather.temp))°C !"
                self.ImageView.image = UIImage(data: weather.imageData)
                self.villeLabel.text = "Bienvenue à \(weather.city)"
            }
            else {
                print("error")
            }
        }
        
        WeatherService.getWeather(city : "Maubeuge") { succes, weather in
            if succes, let weather = weather {
                self.maubeugeDescription.text = weather.idConditions(id: weather.id)
                self.maubeugeTempLabel.text = "il fait \(String(weather.temp))°C !"
                self.maubeugeImageLabel.image = UIImage(data: weather.imageData)
                self.maubeugeLabel.text = "Chez vous à \(weather.city)"
            }
            else {
                print("error")
            }
        }
        
    }

}

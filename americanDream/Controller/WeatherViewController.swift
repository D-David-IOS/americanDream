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
    
    // instance of WeatherService
    let weather = WeatherService(weatherSession : URLSession(configuration: .default), iconSession: URLSession(configuration: .default))
    
    // when the tab weather is selected the view will appear
    override func viewDidLoad() {
        
        // the weather in New York
        weather.getWeather(request : weather.createWeatherRequest(city: "New+York")) { succes, weather in
            if succes, let weather = weather {
                self.descriptionLabel.text = weather.idConditions(id: weather.id)
                self.temperatureLabel.text = "ici il fait \(String(weather.temp))°C !"
                self.ImageView.image = UIImage(data: weather.imageData)
                self.villeLabel.text = "Bienvenue à \(weather.city)"
            }
            else {
                self.presentAlert(with: "la requête à échouée")
            }
        }
        
        // the Weather in Maubeuge
        weather.getWeather(request : weather.createWeatherRequest(city: "maubeuge")) { succes, weather in
            if succes, let weather = weather {
                self.maubeugeDescription.text = weather.idConditions(id: weather.id)
                self.maubeugeTempLabel.text = "il fait \(String(weather.temp))°C !"
                self.maubeugeImageLabel.image = UIImage(data: weather.imageData)
                self.maubeugeLabel.text = "Chez vous à \(weather.city)"
            }
            else {
                self.presentAlert(with: "la requête à échouée")
            }
        }
        
    }

}

// create a simple alert with presentAlert(with error : "text here")
extension WeatherViewController {
    // create an alert, the parameter "with error" is the error message
    private func presentAlert(with error: String){
        let alertVC = UIAlertController(title: "Erreur", message: error, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertVC.addAction(action)
        present(alertVC, animated: true, completion: nil)
    }
}

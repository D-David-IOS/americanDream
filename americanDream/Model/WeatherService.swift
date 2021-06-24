//
//  WeatherService.swift
//  americanDream
//
//  Created by Debehogne David on 24/06/2021.
//

import Foundation

class WeatherService {
    
    static func getWeather(city : String, callback : @escaping (Bool, Weather?) -> Void){
        
        do {
            var request = URLRequest(url: URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=7559963d904acf8d9f2def0e3f053a79&units=metric")!)
            request.httpMethod = "POST"
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: request) { (data, response,error ) in
                DispatchQueue.main.async{
                    if let data = data , error == nil {
                        print("1516265")
                        if let response = response as? HTTPURLResponse, response.statusCode == 200{
                            print("321")
                            let responseJSON : NSDictionary? = try? JSONSerialization.jsonObject(with: data) as? NSDictionary
                            
                            if let jsonResult = responseJSON {
                                let array = jsonResult["weather"] as! NSArray
                                let weather = array[0] as! NSDictionary
                                let main = jsonResult["main"] as! NSDictionary
                                
                                let id:Int = weather["id"] as! Int
                                print(id)
                                let city:String = jsonResult["name"] as! String
                                print(city)
                                let temp = main["temp"] as! Double
                                print(temp)
                                let icon:String = weather["icon"] as! String
                                print(icon)
                                
                                getImage(icone : icon) { data in
                                    if let data = data {
                                        let currentWeather = Weather(city: city, id: id, temp: temp, imageData: data)
                                        callback(true, currentWeather)
                                    } else {
                                        callback(false,nil)
                                    }
                                }
                                
                            } else {
                                callback(false,nil)
                            }
                            
                        }  else {
                            callback(false,nil)
                        }
                    }  else {
                        callback(false,nil)
                    }
                }
            }
            task.resume()
        }
    }
    
    private static func getImage(icone : String, completionHandler: @escaping (Data?)-> Void){
        let session = URLSession(configuration : .default)
        let task = session.dataTask(with: URL(string: "http://openweathermap.org/img/wn/\(icone)@2x.png")!) { data, response, error in
            DispatchQueue.main.async{

            if let data = data , error == nil {
                print("aeazraf")
                if let response = response as? HTTPURLResponse, response.statusCode == 200{
                    completionHandler(data)
                } else {
                    completionHandler(nil)
                }
            } else {
                completionHandler(nil)
            }
        }
        }
        task.resume()
    }
    
}

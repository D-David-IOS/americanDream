//
//  WeatherService.swift
//  americanDream
//
//  Created by Debehogne David on 24/06/2021.
//

import Foundation

class WeatherService {
    
    // injection dependency for UnitTests
    private let weatherSession : URLSession
    private let iconSession : URLSession
    
    init(weatherSession : URLSession, iconSession : URLSession){
        self.weatherSession = weatherSession
        self.iconSession = iconSession
    }
    
    // This function return a callback to the contoller with 2 parameters
    // Bool : will be true if succes, false if an error is present or incorrect data
    // Weather : contains the dictionnary of all current money, nil if error
    func getWeather(request : URLRequest, callback : @escaping (Bool, Weather?) -> Void){
        
        var task : URLSessionDataTask?
        
        task?.cancel()
         task = weatherSession.dataTask(with: request) { (data, response,err ) in
            DispatchQueue.main.async{
                
                // if no data or an error is present return callback(false,nil)
                guard let data = data, err == nil else { return callback(false,nil) }
                
                // if the statuscode if 200 all is ok, else return callback(false,nil)
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return callback(false,nil)}
                
                do {
                    
                    // here we have data so we can complete our object Weather
                    let responseJSON : NSDictionary? = try JSONSerialization.jsonObject(with: data) as? NSDictionary
                    
                    if let jsonResult = responseJSON {
                        let array = jsonResult["weather"] as! NSArray
                        let weather = array[0] as! NSDictionary
                        let main = jsonResult["main"] as! NSDictionary
                        
                        let id:Int = weather["id"] as! Int
                        let city:String = jsonResult["name"] as! String
                        let temp = main["temp"] as! Double
                        let icon:String = weather["icon"] as! String
                        
                        
                        self.getImage(icone : icon) { data2 in
                            guard let data2 = data2 else {
                             return callback(false,nil)
                            }
                                let currentWeather = Weather(city: city, id: id, temp: temp, imageData: data2)
                                
                                return callback(true, currentWeather)
                        }
                    }
                } catch let jsonErr {
                    // if decode failed, show an error and callback(false,nil)
                    print("Erreur de décodage", jsonErr)
                    return callback(false,nil)
                }
            }
        }
        task?.resume()
    }
    
    // This function return a callback to the contoller with 1 parameter
    // Data : contains the image data , nil if error
     func getImage(icone : String, completionHandler: @escaping (Data?)-> Void){
        let request = createIconRequest(icone: icone)
        
        var task : URLSessionDataTask?
        
        task?.cancel()
        task = iconSession.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async{
                
                guard let data = data , error == nil else {
                    completionHandler(nil)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completionHandler(nil)
                    return
                }

                completionHandler(data)
            }
        }
        task?.resume()
    }
    
    
    // create a request to the api "openweather"
    public func createWeatherRequest(city : String) -> URLRequest {
        var request = URLRequest(url: URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=7559963d904acf8d9f2def0e3f053a79&units=metric")!)
        request.httpMethod = "POST"
        return request
    }
    
    // create a request for GET the icone
    public func createIconRequest(icone : String) -> URLRequest{
        var request = URLRequest(url: URL(string: "http://openweathermap.org/img/wn/\(icone)@2x.png")!)
        request.httpMethod = "GET"
        return request
    }
}

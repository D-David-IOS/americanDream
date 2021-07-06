//
//  Weather.swift
//  americanDream
//
//  Created by Debehogne David on 22/06/2021.
//

import Foundation

// in the struct weather we need only 4 properties
// city : the city where we want to see the Weather
// id : is the condition, we can switch it in the function idConditions
// temp : the current temperature
// imageData : the icon with clouds, sun, rain etc....
struct Weather {
    
    var city : String
    var id : Int
    var temp : Double
    var imageData : Data
    
    // return a String with the conditions, "clouds", "sun with clouds" etc...
    func idConditions(id : Int) -> String {
        switch id {
        case 200...202:
            return "Pluies avec des orages"
        case 210...211:
            return "Risques d'orages"
        case 212...221:
            return "Violents orages"
        case 230...232:
            return "Orage avec bruine"
        case 300...321:
            return "Temps nuageux avec pluies"
        case 500...504:
            return "Temps ensoleillé avec pluies"
        case 511:
            return "Pluies avec risque de neige"
        case 520...531:
            return "Fortes pluies"
        case 600...622:
            return "Risques de neiges"
        case 701...781:
            return "Risques de brouillards"
        case 800:
            return "Ciel dégagé"
        case 801...804:
            return "Temps nuageux"
        default:
            return "Ciel dégagé"
        }
    }
    
}




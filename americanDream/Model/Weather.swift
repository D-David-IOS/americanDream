//
//  Weather.swift
//  americanDream
//
//  Created by Debehogne David on 22/06/2021.
//

import Foundation

struct Weather {
    
    var city : String
    var id : Int
    var temp : Double
    var imageData : Data
    
    func printall( osef : Weather){
        print(osef.city)
        print(osef.id)
        print(osef.temp)
    }
    
    func idConditions(id : Int) -> [String] {
        switch id {
        case 200...202:
            return ["11d","Pluies avec des orages"]
        case 210...211:
            return ["11d","Risques d'orages"]
        case 212...221:
            return ["11d","Violents orages"]
        case 230...232:
            return ["11d","Orage avec bruine"]
        case 300...321:
            return ["09d","Temps nuageux avec pluies"]
        case 500...504:
            return ["09d","Temps ensoleillé avec pluies"]
        case 511:
            return ["13d","Pluies avec risque de neige"]
        case 520...531:
            return ["09D","Fortes pluies"]
        case 600...622:
            return ["13d","Risques de neiges"]
        case 701...781:
            return ["50d","Risques de brouillards"]
        case 800:
            return ["01d","Ciel dégagé"]
        case 801...804:
            return ["02d","Temps nuageux"]
        default:
            return ["01d","Ciel dégagé"]
        }
    }
    
}




//
//  Traduction.swift
//  americanDream
//
//  Created by Debehogne David on 26/06/2021.
//

import Foundation

struct Traduction : Decodable {
    let data : [String : [Resultat]]

    func returnTranslate() -> String {
        return data["translations"]![0].translatedText
    }
}

struct Resultat : Decodable {
    let translatedText : String
    let detectedSourceLanguage : String

}

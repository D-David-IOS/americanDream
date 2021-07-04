//
//  Traduction.swift
//  americanDream
//
//  Created by Debehogne David on 26/06/2021.
//

import Foundation

// the struct Translate is decodable
// we can use it in the function returnTranslate to have the translation
struct Translate : Decodable {
    let data : [String : [Result]]

    // return the text translated
    func returnTranslate() -> String {
        return data["translations"]![0].translatedText
    }
}

// the struct Result is used in Translate
// we can use Translate more easily
struct Result : Decodable {
    let translatedText : String
    let detectedSourceLanguage : String

}

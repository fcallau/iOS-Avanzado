//
//  String+Language.swift
//  MadridShops
//
//  Created by Francesc Callau Brull on 25/9/17.
//  Copyright © 2017 fcallau. All rights reserved.
//

import Foundation

extension String {
    // Usage example: String.obtainLiteral(es: "¡Hola Mundo!", en: "Hello World!")
    static func obtainLiteral(es: String, en: String) -> String {
        if let languageCode = Locale.current.languageCode {
            let tempLanguageCode = languageCode
            // let tempLanguageCode = "es"
            
            switch tempLanguageCode {
            case "es":
                return es
            default:
                return en
            }
        }
        
        return en
    }
}

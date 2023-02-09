//
//  TextPicker.swift
//  WeatherReport
//
//  Created by Vladislav Green on 1/26/23.
//

import UIKit

class TextPicker {
    
    static let defaultPicker = TextPicker()
    
    func showPicker(in viewController: UIViewController, withMessage: String, completion: @escaping (_ text: String) -> Void) {
        
        let alertController = UIAlertController(title: withMessage, message: "Используйте латиницу", preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "Enter text"
        }
        
        let actionOK = UIAlertAction(title: "OK", style: .default) {
            action in
            if let text = alertController.textFields?[0].text, text != ""
            // проверка на латиницу
            {
                let textTransliterated = self.transliterate(nonLatin: text)
                completion(textTransliterated)
            }
        }
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(actionOK)
        alertController.addAction(actionCancel)
        
        viewController.present(alertController, animated: true)
    }
    
    
    func transliterate(nonLatin: String) -> String {
        return (nonLatin
            .applyingTransform(.toLatin, reverse: false)?
            .applyingTransform(.stripDiacritics, reverse: false))!
//            .lowercased()
//            .replacingOccurrences(of: " ", with: "-") ?? nonLatin
    }
    
    
    func showMessage(in viewController: UIViewController, title: String, text: String) {
        let alertController = UIAlertController(title: title, message: text, preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(actionOK)
        viewController.present(alertController, animated: true)
        
    }
}

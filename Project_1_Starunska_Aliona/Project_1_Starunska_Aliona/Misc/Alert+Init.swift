//
//  Alert+Init.swift
//  Project_1_Starunska_Aliona
//
//  Created by Aliona Starunska on 27.01.2021.
//

import UIKit

extension UIAlertController {
    static func make(with message: String = "Error", completion: Event? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: { (_) in
            alertController.dismiss(animated: true) {
                completion?()
            }
        }))
        return alertController
    }
}

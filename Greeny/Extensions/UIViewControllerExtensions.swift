//
//  UIViewControllerExtensions.swift
//  Jumping
//
//  Created by Tung Nguyen on 5/13/18.
//  Copyright © 2018 tungbk. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func alert(message: String) {
        let alertController = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
}


//
//  UIAlertControllerExtension.swift
//  FlickrApp
//
//  Created by Gabor Horvath on 2019. 10. 07..
//  Copyright © 2019. Gabor Horvath. All rights reserved.
//

import UIKit

extension UIAlertController {
    static func showErrorDetails(error: Error) {
        let alertViewController = UIAlertController(title: "error".localized, message: error.message(), preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok".localized, style: .default, handler: .none)
        alertViewController.addAction(okAction)
        if let keyWindow = UIApplication.shared.keyWindow, let rootViewController = keyWindow.rootViewController {
            rootViewController.present(alertViewController, animated: true)
        }
    }
}

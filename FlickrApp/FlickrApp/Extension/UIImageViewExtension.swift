//
//  UIImageViewExtension.swift
//  FlickrApp
//
//  Created by Gabor Horvath on 2019. 10. 03..
//  Copyright © 2019. Gabor Horvath. All rights reserved.
//

import UIKit

extension UIImageView {

    func load(url: URL) {
        let activityIndicatorView = UIActivityIndicatorView(style: .white)
        activityIndicatorView.center = CGPoint(x: frame.size.width/2, y:frame.size.height/2)
        activityIndicatorView.startAnimating()
        activityIndicatorView.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        activityIndicatorView.color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)

        addSubview(activityIndicatorView)

        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

        DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                        DispatchQueue.main.async {
                        if let image = UIImage(data: data) {
                                activityIndicatorView.removeFromSuperview()
                                self?.image = image
                        } else {
                                activityIndicatorView.removeFromSuperview()
                                self?.image = #imageLiteral(resourceName: "missing-image")

                        }
                    }
            } else {
                DispatchQueue.main.async {
                    activityIndicatorView.removeFromSuperview()
                    self?.image = #imageLiteral(resourceName: "missing-image")
                }
            }
        }
    }
}

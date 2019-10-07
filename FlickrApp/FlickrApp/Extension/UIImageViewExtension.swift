//
//  UIImageViewExtension.swift
//  FlickrApp
//
//  Created by Gabor Horvath on 2019. 10. 03..
//  Copyright © 2019. Gabor Horvath. All rights reserved.
//

import UIKit

extension UIImageView {

    func load(urlString: String, cacheEnabled: Bool = false) {
        LogService.shared.debug(" load image - url: \(urlString) cacheEnabled: \(cacheEnabled ? "YES": "NO")")

        if cacheEnabled, let imageData = ThumbnailCacheService.shared.getImage(for: urlString), let image = UIImage(data: imageData) {
            LogService.shared.debug("cached image available")
            self.image = image
        } else {
            LogService.shared.debug("cached image not available")
            let activityIndicatorView = UIActivityIndicatorView(style: .white)
            activityIndicatorView.center = CGPoint(x: frame.size.width/2, y:frame.size.height/2)
            activityIndicatorView.startAnimating()
            activityIndicatorView.color = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)

            addSubview(activityIndicatorView)

            activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
            activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            activityIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

            DispatchQueue.global().async { [weak self] in
                    if let url = URL(string: urlString), let data = try? Data(contentsOf: url) {
                        DispatchQueue.main.async {
                        if let image = UIImage(data: data) {
                            if cacheEnabled {
                                ThumbnailCacheService.shared.cache(imageData: data, url: urlString)
                            }
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
}

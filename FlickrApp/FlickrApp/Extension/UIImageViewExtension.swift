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
        let activityIndicatorView = UIActivityIndicatorView(style: .gray)
        activityIndicatorView.center = CGPoint(x: frame.size.width/2, y:frame.size.height/2)
        activityIndicatorView.startAnimating()
        addSubview(activityIndicatorView)
        
        DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                        DispatchQueue.main.async {
                        if let image = UIImage(data: data) {
                                activityIndicatorView.removeFromSuperview()
                                self?.image = image
                        } else {
                                activityIndicatorView.removeFromSuperview()
                        }
                    }
            } else {
                DispatchQueue.main.async {
                    activityIndicatorView.removeFromSuperview()
                }
            }
        }
    }
}

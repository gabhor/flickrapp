//
//  ImageDetailsViewController.swift
//  FlickrApp
//
//  Created by Gabor Horvath on 2019. 10. 01..
//  Copyright © 2019. Gabor Horvath. All rights reserved.
//

import UIKit

class ImageDetailsViewController: UIViewController {

    func configureView() {
        if let detail = detailItem {
            //TODO
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    var detailItem: FlickrPhoto? {
        didSet {
            configureView()
        }
    }


}


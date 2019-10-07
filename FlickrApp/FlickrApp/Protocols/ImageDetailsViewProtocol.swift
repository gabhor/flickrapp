//
//  ImageDetailsViewProtocol.swift
//  FlickrApp
//
//  Created by Gabor Horvath on 2019. 10. 03..
//  Copyright © 2019. Gabor Horvath. All rights reserved.
//

import Foundation

protocol ImageDetailsViewProtocol : class {
    func update(with photo:FlickrPhotoDetails)
    func update(with error:Error)
}


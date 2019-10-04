//
//  ImageListViewProtocol.swift
//  FlickrApp
//
//  Created by Gabor Horvath on 2019. 10. 03..
//  Copyright © 2019. Gabor Horvath. All rights reserved.
//

import Foundation

protocol ImageListViewProtocol : class {
    func isLoading(_ loading: Bool)
    func refresh()
    func update(with error:Error)
}

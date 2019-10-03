//
//  ResponseModelProtocol.swift
//  FlickrApp
//
//  Created by Gabor Horvath on 2019. 10. 02..
//  Copyright © 2019. Gabor Horvath. All rights reserved.
//

import Foundation

protocol ResponseModelProtocol {
    var stat: String { get }
    var message: String? { get }
    var code: Int? { get }
}

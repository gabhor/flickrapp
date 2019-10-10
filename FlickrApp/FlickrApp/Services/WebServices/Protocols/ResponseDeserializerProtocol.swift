//
//  ResponseDeserializerProtocol.swift
//  FlickrApp
//
//  Created by Gabor Horvath on 2019. 10. 01..
//  Copyright © 2019. Gabor Horvath. All rights reserved.
//

import Foundation

protocol ResponseDeserializerProtocol {
    func responseModel(fromJsonData jsonData: AnyObject) -> ResponseModelProtocol
}

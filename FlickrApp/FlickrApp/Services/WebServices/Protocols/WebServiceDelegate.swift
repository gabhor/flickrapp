//
//  WebServiceDelegate.swift
//  FlickrApp
//
//  Created by Gabor Horvath on 2019. 10. 02..
//  Copyright © 2019. Gabor Horvath. All rights reserved.
//

import Foundation

protocol WebServiceDelegate: class {
    func serviceFinished(withResponse response: ResponseModelProtocol)
    func serviceFinished(withError error: Error)
}

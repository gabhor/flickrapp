//
//  StringExtension.swift
//  FlickrApp
//
//  Created by Gabor Horvath on 2019. 10. 04..
//  Copyright © 2019. Gabor Horvath. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

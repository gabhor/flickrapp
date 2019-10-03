//
//  DictionaryExtension.swift
//  FlickrApp
//
//  Created by Gabor Horvath on 2019. 10. 03..
//  Copyright © 2019. Gabor Horvath. All rights reserved.
//

import Foundation

extension Dictionary {
    func queryDataString () -> String {
        let keyValuePairs = self.compactMap { (arg0) -> String? in
            if let key = arg0.key as? String, let value = arg0.value as? String {
                return key + "=" + value
            } else {
                return .none
            }
        }
        return keyValuePairs.joined(separator: "&")
    }
}

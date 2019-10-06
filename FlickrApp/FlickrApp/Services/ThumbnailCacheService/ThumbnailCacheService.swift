//
//  ThumbnailCacheService.swift
//  FlickrApp
//
//  Created by Gabor Horvath on 2019. 10. 06..
//  Copyright © 2019. Gabor Horvath. All rights reserved.
//

import Foundation

class ThumbnailCacheService {

    static let shared = ThumbnailCacheService()

    private var inMemoryCache = [String: Data]()

    func cache(imageData: Data, url: String) {
        inMemoryCache[url] = imageData
    }

    func getImage(for url:String) -> Data? {
        return inMemoryCache[url]
    }
}

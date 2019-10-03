//
//  FlickrPhotoNode.swift
//  FlickrApp
//
//  Created by Gabor Horvath on 2019. 10. 03..
//  Copyright © 2019. Gabor Horvath. All rights reserved.
//

import Foundation

struct FlickrPhoto {
    
    let photoId: String?
    let owner: String?
    let secret: String?
    let server: String?
    let farm: Int?
    let title: String?

    static func fromJsonData(_ jsonData: [String: Any]) -> FlickrPhoto {
        
        return FlickrPhoto(photoId: jsonData[Constant.FlickrPhoto.idKey] as? String,
                           owner: jsonData[Constant.FlickrPhoto.ownerKey] as? String,
                           secret: jsonData[Constant.FlickrPhoto.secretKey] as? String,
                           server: jsonData[Constant.FlickrPhoto.serverKey] as? String,
                           farm: jsonData[Constant.FlickrPhoto.farmKey] as? Int,
                           title: jsonData[Constant.FlickrPhoto.titleKey] as? String)
    }

    func thumbnailUrl() -> URL? {
        guard let farm = farm, let server = server, let photoId = photoId, let secret = secret else { return .none }
        let urlString = "https://farm\(farm).staticflickr.com/\(server)/\(photoId)_\(secret)_t.jpg"
        return URL(string: urlString)
    }
}

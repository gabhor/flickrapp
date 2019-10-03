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
    let isPublic: Bool?
    let isFriend: Bool?
    let isFamily: Bool?

    static func fromJsonData(_ jsonData: AnyObject) -> FlickrPhoto {
        let isPublicInt = boolValue(from: jsonData[Constant.FlickrPhoto.isPublicFieldName] as Any?)
        let isFriendInt = boolValue(from: jsonData[Constant.FlickrPhoto.isFriendFieldName] as Any?)
        let isFamilyInt = boolValue(from: jsonData[Constant.FlickrPhoto.isFamilyFieldName] as Any?)

        return FlickrPhoto(photoId: jsonData[Constant.FlickrPhoto.idFieldName] as? String,
                           owner: jsonData[Constant.FlickrPhoto.ownerFieldName] as? String,
                           secret: jsonData[Constant.FlickrPhoto.secretFieldName] as? String,
                           server: jsonData[Constant.FlickrPhoto.serverFieldName] as? String,
                           farm: jsonData[Constant.FlickrPhoto.farmFieldName] as? Int,
                           title: jsonData[Constant.FlickrPhoto.titleFieldName] as? String,
                           isPublic: isPublicInt,
                           isFriend: isFriendInt,
                           isFamily: isFamilyInt)
    }

    static func boolValue(from value: Any?) -> Bool? {
        guard let value = value as? NSNumber else { return nil }
        
        return Bool(truncating: value)
    }

    func thumbnailUrl() -> URL? {
        guard let farm = farm, let server = server, let photoId = photoId, let secret = secret else { return .none }
        let urlString = "https://farm\(farm).staticflickr.com/\(server)/\(photoId)_\(secret)_t.jpg"
        return URL(string: urlString)
    }
}

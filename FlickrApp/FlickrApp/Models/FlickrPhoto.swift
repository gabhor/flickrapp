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
        
        return FlickrPhoto(photoId: jsonData[Constant.ResponseParameter.photoId] as? String,
                           owner: jsonData[Constant.ResponseParameter.owner] as? String,
                           secret: jsonData[Constant.ResponseParameter.secret] as? String,
                           server: jsonData[Constant.ResponseParameter.server] as? String,
                           farm: jsonData[Constant.ResponseParameter.farm] as? Int,
                           title: jsonData[Constant.ResponseParameter.title] as? String)
    }

    func thumbnailUrl() -> String? {
        guard let farm = farm, let server = server, let photoId = photoId, let secret = secret else { return .none }

        var urlString = Constant.PhotoUrl.thumbnail
        urlString = urlString.replacingOccurrences(of: Constant.PhotoUrl.Parameter.farm, with: String(farm))
        urlString = urlString.replacingOccurrences(of: Constant.PhotoUrl.Parameter.server, with: server)
        urlString = urlString.replacingOccurrences(of: Constant.PhotoUrl.Parameter.photoId, with: photoId)
        urlString = urlString.replacingOccurrences(of: Constant.PhotoUrl.Parameter.secret, with: secret)
        return urlString
    }
}

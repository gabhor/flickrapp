//
//  FlickrPhotoDetails.swift
//  FlickrApp
//
//  Created by Gabor Horvath on 2019. 10. 03..
//  Copyright © 2019. Gabor Horvath. All rights reserved.
//

import Foundation

struct FlickrPhotoDetails {

    let photoId: String?
    let secret: String?
    let server: String?
    let farm: Int?
    let originalSecret: String?
    let originalFormat: String?
    let ownerUserName: String?
    let ownerRealName: String?
    let title: String?
    let description: String?
    let taken: String?

    static func fromJsonData(_ jsonData: [String: Any]) -> FlickrPhotoDetails {
        let photoData = jsonData[Constant.FlickrPhoto.photoKey] as? [String: Any]
        let ownerData = photoData?[Constant.FlickrPhoto.ownerKey] as? [String: Any]
        let titleData = photoData?[Constant.FlickrPhoto.titleKey] as? [String: Any]
        let descriptionData = photoData?[Constant.FlickrPhoto.descriptionKey] as? [String: Any]
        let datesData = photoData?[Constant.FlickrPhoto.datesKey] as? [String: Any]

        return FlickrPhotoDetails(photoId: photoData?[Constant.FlickrPhoto.idKey] as? String,
                                  secret: photoData?[Constant.FlickrPhoto.secretKey] as? String,
                                  server: photoData?[Constant.FlickrPhoto.serverKey] as? String,
                                  farm: photoData?[Constant.FlickrPhoto.farmKey] as? Int,
                                  originalSecret: photoData?[Constant.FlickrPhoto.originalSecretKey] as? String,
                                  originalFormat: photoData?[Constant.FlickrPhoto.originalFormatKey] as? String,
                                  ownerUserName: ownerData?[Constant.FlickrPhoto.userNameKey] as? String,
                                  ownerRealName: ownerData?[Constant.FlickrPhoto.realNameKey] as? String,
                                  title: titleData?[Constant.FlickrPhoto.contentKey] as? String,
                                  description: descriptionData?[Constant.FlickrPhoto.contentKey] as? String,
                                  taken: datesData?[Constant.FlickrPhoto.takenDateKey] as? String)
    }

    func imageUrl() -> URL? {
        guard let farm = farm, let server = server, let photoId = photoId, let originalSecret = originalSecret, let originalFormat = originalFormat else { return .none }
        let urlString = "https://farm\(farm).staticflickr.com/\(server)/\(photoId)_\(originalSecret)_o.\(originalFormat))"
        return URL(string: urlString)
    }
}

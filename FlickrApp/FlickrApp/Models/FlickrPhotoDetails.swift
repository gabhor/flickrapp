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
        let ownerData = jsonData[Constant.ResponseParameter.owner] as? [String: Any]
        let titleData = jsonData[Constant.ResponseParameter.title] as? [String: Any]
        let descriptionData = jsonData[Constant.ResponseParameter.description] as? [String: Any]
        let datesData = jsonData[Constant.ResponseParameter.dates] as? [String: Any]

        return FlickrPhotoDetails(photoId: jsonData[Constant.ResponseParameter.photoId] as? String,
                                  secret: jsonData[Constant.ResponseParameter.secret] as? String,
                                  server: jsonData[Constant.ResponseParameter.server] as? String,
                                  farm: jsonData[Constant.ResponseParameter.farm] as? Int,
                                  originalSecret: jsonData[Constant.ResponseParameter.originalSecret] as? String,
                                  originalFormat: jsonData[Constant.ResponseParameter.originalFormat] as? String,
                                  ownerUserName: ownerData?[Constant.ResponseParameter.userName] as? String,
                                  ownerRealName: ownerData?[Constant.ResponseParameter.realName] as? String,
                                  title: titleData?[Constant.ResponseParameter.content] as? String,
                                  description: descriptionData?[Constant.ResponseParameter.content] as? String,
                                  taken: datesData?[Constant.ResponseParameter.takenDate] as? String)
    }

    func originalImageUrl() -> String? {
        guard let farm = farm, let server = server, let photoId = photoId, let originalSecret = originalSecret, let originalFormat = originalFormat else { return .none }

        var urlString = Constant.PhotoUrl.original
        urlString = urlString.replacingOccurrences(of: Constant.PhotoUrl.Parameter.farm, with: String(farm))
        urlString = urlString.replacingOccurrences(of: Constant.PhotoUrl.Parameter.server, with: server)
        urlString = urlString.replacingOccurrences(of: Constant.PhotoUrl.Parameter.photoId, with: photoId)
        urlString = urlString.replacingOccurrences(of: Constant.PhotoUrl.Parameter.originalSecret, with: originalSecret)
        urlString = urlString.replacingOccurrences(of: Constant.PhotoUrl.Parameter.originalFormat, with: originalFormat)

        return urlString
    }

    func largeImageUrl() -> String? {
        guard let farm = farm, let server = server, let photoId = photoId, let secret = secret else { return .none }

        var urlString = Constant.PhotoUrl.large
        urlString = urlString.replacingOccurrences(of: Constant.PhotoUrl.Parameter.farm, with: String(farm))
        urlString = urlString.replacingOccurrences(of: Constant.PhotoUrl.Parameter.server, with: server)
        urlString = urlString.replacingOccurrences(of: Constant.PhotoUrl.Parameter.photoId, with: photoId)
        urlString = urlString.replacingOccurrences(of: Constant.PhotoUrl.Parameter.secret, with: secret)

        return urlString
    }
}

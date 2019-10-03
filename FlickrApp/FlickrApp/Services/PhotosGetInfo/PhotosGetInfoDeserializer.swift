//
//  PhotosGetInfoDeserializer.swift
//  FlickrApp
//
//  Created by Gabor Horvath on 2019. 10. 03..
//  Copyright © 2019. Gabor Horvath. All rights reserved.
//

import Foundation

class PhotosGetInfoDeserializer: ResponseDeserializerProtocol {
    func responseModel(fromJsonData jsonData: AnyObject) -> ResponseModelProtocol {
        guard let _ = jsonData as? [String: Any], let stat = jsonData[Constant.FlickrService.statKey] as? String else {
            return PhotosGetInfo.ResponseModel(stat: Constant.FlickrService.statFieldFailedValue, message: .none, code: Constant.Error.generalError, photoDetails: .none)
        }

        return PhotosGetInfo.ResponseModel(stat: stat, message: jsonData[Constant.FlickrService.messageKey] as? String, code: jsonData[Constant.FlickrService.codeKey] as? Int, photoDetails: photoDetails(from: jsonData))
    }
}

private extension PhotosGetInfoDeserializer {
    func photoDetails(from jsonData: AnyObject) -> FlickrPhotoDetails? {
        guard let _ = jsonData as? [String: Any], let photoData = jsonData[Constant.FlickrPhoto.photoKey]  as? [String: Any] else { return .none }

        return FlickrPhotoDetails.fromJsonData(photoData)
    }
}

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
        guard let _ = jsonData as? [String: Any], let stat = jsonData[Constant.ResponseParameter.stat] as? String else {
            return PhotosGetInfo.ResponseModel(stat: Constant.ResponseParameter.stat, message: .none, code: Constant.Error.Code.jsonStructError, photoDetails: .none)
        }

        return PhotosGetInfo.ResponseModel(stat: stat, message: jsonData[Constant.ResponseParameter.message] as? String, code: jsonData[Constant.ResponseParameter.code] as? Int, photoDetails: photoDetails(from: jsonData))
    }
}

// MARK: - Private extension

private extension PhotosGetInfoDeserializer {
    func photoDetails(from jsonData: AnyObject) -> FlickrPhotoDetails? {
        guard let _ = jsonData as? [String: Any], let photoData = jsonData[Constant.ResponseParameter.photo]  as? [String: Any] else { return .none }

        return FlickrPhotoDetails.fromJsonData(photoData)
    }
}

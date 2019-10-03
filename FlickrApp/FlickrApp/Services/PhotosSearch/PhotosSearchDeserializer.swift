//
//  PhotosSearchDeserializer.swift
//  FlickrApp
//
//  Created by Gabor Horvath on 2019. 10. 03..
//  Copyright © 2019. Gabor Horvath. All rights reserved.
//

import Foundation

class PhotosSearchDeserializer: ResponseDeserializerProtocol {
    func responseModel(fromJsonData jsonData: AnyObject) -> ResponseModelProtocol {
        guard let jsonDict = jsonData as? [String: Any], let stat = jsonData[Constant.FlickrService.statFieldName] as? String else {
            return PhotosSearch.ResponseModel(stat: Constant.FlickrService.statFieldFailedValue, message: .none, code: Constant.Error.generalError, photos: .none)
        }

        let photosNode = jsonDict[Constant.FlickrService.photosFieldName]
        return PhotosSearch.ResponseModel(stat: stat, message: jsonData[Constant.FlickrService.messageFieldName] as? String, code: jsonData[Constant.FlickrService.codeFieldName] as? Int, photos: photos(from: photosNode))
    }
}

private extension PhotosSearchDeserializer {
    func photos(from photosNode: Any?) -> [FlickrPhoto]? {
        guard let photosNode = photosNode as? [String: Any], let photoNode = photosNode[Constant.FlickrService.photoFieldName] as? [[String: Any]] else { return .none }

        return photoNode.compactMap({ FlickrPhoto.fromJsonData($0 as AnyObject) })
    }
}

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
        guard let jsonDict = jsonData as? [String: Any], let stat = jsonData[Constant.ResponseParameter.stat] as? String else {
            return PhotosSearch.ResponseModel(stat: Constant.ResponseParameter.stat, message: .none, code: Constant.Error.generalError, photos: .none)
        }

        let photosNode = jsonDict[Constant.ResponseParameter.photos]
        return PhotosSearch.ResponseModel(stat: stat, message: jsonData[Constant.ResponseParameter.message] as? String, code: jsonData[Constant.ResponseParameter.code] as? Int, photos: photos(from: photosNode))
    }
}

// MARK: - Private extension

private extension PhotosSearchDeserializer {
    func photos(from photosNode: Any?) -> [FlickrPhoto]? {
        guard let photosNode = photosNode as? [String: Any], let photoNode = photosNode[Constant.ResponseParameter.photo] as? [[String: Any]] else { return .none }

        return photoNode.compactMap({
            FlickrPhoto.fromJsonData($0)
        })
    }
}

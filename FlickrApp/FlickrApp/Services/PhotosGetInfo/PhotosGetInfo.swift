//
//  PhotosGetInfo.swift
//  FlickrApp
//
//  Created by Gabor Horvath on 2019. 10. 03..
//  Copyright © 2019. Gabor Horvath. All rights reserved.
//

import Foundation

struct PhotosGetInfo {
    struct RequestModel: RequestModelProtocol {
        var photoId: String
        var secret: String?

        func queryDataString () -> String {
            queryData().queryDataString()
        }

        private func queryData() -> [String: String] {
            var queryData = [
                    Constant.FlickrService.methodFieldName: Constant.FlickrService.photosGetInfoMethodValue,
                    Constant.FlickrService.apiKeyFieldName: Constant.FlickrService.apiKey,
                    Constant.FlickrService.formatFieldName: Constant.FlickrService.format,
                    Constant.FlickrService.noJsonCallbackFieldName: Constant.FlickrService.noJsonCallback,
                    Constant.FlickrService.photoIdFieldName: photoId
            ]

            if let secret = secret {
                queryData[Constant.FlickrService.secretFieldName] = secret
            }

            return queryData
        }


    }

    struct ResponseModel: ResponseModelProtocol {
        let stat: String
        let message: String?
        let code: Int?
        let photoDetails: FlickrPhotoDetails?
    }
}

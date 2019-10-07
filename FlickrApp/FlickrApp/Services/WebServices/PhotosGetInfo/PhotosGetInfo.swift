//
//  PhotosGetInfo.swift
//  FlickrApp
//
//  Created by Gabor Horvath on 2019. 10. 03..
//  Copyright © 2019. Gabor Horvath. All rights reserved.
//

import Foundation
//TODO TEST
struct PhotosGetInfo {
    struct RequestModel: RequestModelProtocol {
        var photoId: String
        var secret: String?

        func queryDataString () -> String {
            queryData().queryDataString()
        }

        private func queryData() -> [String: String] {
            var queryData = [
                Constant.RequestParameter.method: Constant.FlickrService.Method.photosGetInfo,
                    Constant.RequestParameter.apiKey: Constant.FlickrService.apiKey,
                    Constant.RequestParameter.format: Constant.FlickrService.format,
                    Constant.RequestParameter.noJsonCallback: Constant.FlickrService.noJsonCallback,
                    Constant.RequestParameter.photoId: photoId
            ]

            if let secret = secret {
                queryData[Constant.RequestParameter.secret] = secret
            }

            return queryData
        }


    }

    struct ResponseModel: ResponseModelProtocol {
        let stat: String
        let message: String?
        let code: Int?
        let photoDetails: FlickrPhotoDetails?
        var error: NSError? {
            if let code = code {
                var userInfo = [String: String]()
                if let message = message {
                    userInfo[Constant.Error.serviceMessageKey] = message
                }
                return NSError(domain: Constant.Error.Domain.photosGetInfoService, code: code, userInfo: userInfo)
            }
            return .none
        }
    }
}

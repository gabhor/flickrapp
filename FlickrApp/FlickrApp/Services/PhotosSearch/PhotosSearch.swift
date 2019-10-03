//
//  PhotosSearch.swift
//  FlickrApp
//
//  Created by Gabor Horvath on 2019. 10. 01..
//  Copyright © 2019. Gabor Horvath. All rights reserved.
//

import Foundation

struct PhotosSearch {
    struct RequestModel: RequestModelProtocol {
        var text: String?
        var perPage: Int?
        var page: Int?

        func queryDataString () -> String {
            queryData().queryDataString()
        }
        
        private func queryData() -> [String: String] {
            var queryData = [
                    Constant.FlickrService.methodFieldName: Constant.FlickrService.photosSearchMethodValue,
                    Constant.FlickrService.apiKeyFieldName: Constant.FlickrService.apiKey,
                    Constant.FlickrService.formatFieldName: Constant.FlickrService.format,
                    Constant.FlickrService.noJsonCallbackFieldName: Constant.FlickrService.noJsonCallback]

            if let text = text {
                queryData[Constant.FlickrService.textFieldName] = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            }

            if let perPage = perPage {
                queryData[Constant.FlickrService.perPageFieldName] = "\(perPage)"
            } else {
                queryData[Constant.FlickrService.perPageFieldName] = "\(Constant.FlickrService.perPageDefaultValue)"
            }

            if let page = page {
                queryData[Constant.FlickrService.pageFieldName] = "\(page)"
            }

            return queryData
        }


    }

    struct ResponseModel: ResponseModelProtocol {
        let stat: String
        let message: String?
        let code: Int?
        let photos: [FlickrPhoto]?

        
    }
}

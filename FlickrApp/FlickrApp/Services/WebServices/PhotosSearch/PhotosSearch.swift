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
                Constant.RequestParameter.method: Constant.FlickrService.Method.photosSearch,
                    Constant.RequestParameter.apiKey: Constant.FlickrService.apiKey,
                    Constant.RequestParameter.format: Constant.FlickrService.format,
                    Constant.RequestParameter.noJsonCallback: Constant.FlickrService.noJsonCallback]

            if let text = text {
                queryData[Constant.RequestParameter.text] = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            }

            if let perPage = perPage {
                queryData[Constant.RequestParameter.perPage] = "\(perPage)"
            } else {
                queryData[Constant.RequestParameter.perPage] = "\(Constant.App.perPageDefaultValue)"
            }

            if let page = page {
                queryData[Constant.RequestParameter.page] = "\(page)"
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

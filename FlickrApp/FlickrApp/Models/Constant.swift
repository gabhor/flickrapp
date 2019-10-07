//
//  Constant.swift
//  FlickrApp
//
//  Created by Gabor Horvath on 2019. 10. 02..
//  Copyright © 2019. Gabor Horvath. All rights reserved.
//

import Foundation

public enum Constant {

    public enum App {

        public static let appName = "FlickrApp"
        public static let photoCellIdentifier = "PhotoCell"
        public static let showDetailSegue = "showDetail"
        public static let initialSearchText = "dog"
        public static let perPageDefaultValue = 20
        public static let storedKeywordKey = "kStoredSearchjKeyword"
        #if DEBUG
            public static let logLevel = LogLevel.debug
        #else
            public static let logLevel = LogLevel.error
        #endif
    }
    public enum FlickrService {

        // service data
        public static let restServiceUrl = "https://www.flickr.com/services/rest/"
        public static let defaultTimeoutInterval = 30
        public static let apiKey = "65803e8f6e4a3982200621cad356be51"
        public static let format = "json"
        public static let media = "photos"
        public static let noJsonCallback = "1"

        public enum Method {

            public static let photosSearch = "flickr.photos.search"
            public static let photosGetInfo = "flickr.photos.getInfo"
        }


        public enum Result {

            public static let successful = "ok"
            public static let failed = "fail"
        }
    }

    public enum RequestParameter {

        public static let apiKey = "api_key"
        public static let format = "format"
        public static let noJsonCallback = "nojsoncallback"
        public static let method = "method"
        public static let text = "text"
        public static let perPage = "per_page"
        public static let page = "page"
        public static let photoId = "photo_ids"
        public static let secret = "secret"
        public static let media = "media"
    }

    public enum ResponseParameter {

        public static let stat = "stat"
        public static let message = "message"
        public static let code = "code"
        public static let photos = "photos"
        public static let photo = "photo"
        public static let photoId = "id"
        public static let owner = "owner"
        public static let secret = "secret"
        public static let server = "server"
        public static let farm = "farm"
        public static let title = "title"
        public static let description = "description"
        public static let originalSecret = "originalsecret"
        public static let originalFormat = "originalformat"
        public static let userName = "username"
        public static let realName = "realname"
        public static let content = "_content"
        public static let dates = "dates"
        public static let takenDate = "taken"
    }

    public enum WebService {

        public static let defaultTimeoutInterval = 30.0
        public static let method = "POST"

    }

    public enum Error {

        public enum Domain {

            public static let app = "AppErrorDomain"
            public static let communication = "CommunicationErrorDomain"
            public static let photosSearchService = "PhotosSearchServiceErrorDomain"
            public static let photosGetInfoService = "PhotosGetInfoServiceErrorDomain"
        }

        public enum Code {

            public static let communicationError = -1009
            public static let generalError = -1
            public static let jsonParseError = -2
            public static let jsonStructError = -3
            public static let emptyResponseError = -4
        }

        public static let serviceMessageKey = "serviceMessage"
        public static let serviceGeneralErrorTreshold = 100
    }


    public enum PhotoUrl {

            public static let thumbnail = "https://farm[FARM].staticflickr.com/[SERVER]/[ID]_[SECRET]_m.jpg"
            public static let large = "https://farm[FARM].staticflickr.com/[SERVER]/[ID]_[SECRET]_b.jpg"
            public static let original = "https://farm[FARM].staticflickr.com/[SERVER]/[ID]_[ORIGINALSECRET]_o.[ORIGINALFORMAT])"

            public enum Parameter {

                public static let farm = "[FARM]"
                public static let server = "[SERVER]"
                public static let photoId = "[ID]"
                public static let secret = "[SECRET]"
                public static let originalSecret = "[ORIGINALSECRET]"
                public static let originalFormat = "[ORIGINALFORMAT]"
            }
    }

}

//
//  Constant.swift
//  FlickrApp
//
//  Created by Gabor Horvath on 2019. 10. 02..
//  Copyright © 2019. Gabor Horvath. All rights reserved.
//

import Foundation

public enum Constant {

    public enum FlickrService {

        public static let restServiceUrl = "https://www.flickr.com/services/rest/"
        public static let defaultTimeoutInterval = 30

        //request parameter names
        public static let apiKeyFieldName = "api_key"
        public static let formatFieldName = "format"
        public static let noJsonCallbackFieldName = "nojsoncallback"
        public static let methodFieldName = "method"
        public static let textFieldName = "text"
        public static let perPageFieldName = "per_page"
        public static let pageFieldName = "page"

        //static request values
        public static let apiKey = "65803e8f6e4a3982200621cad356be51"
        public static let format = "json"
        public static let noJsonCallback = "1"

        //default request values
        public static let perPageDefaultValue = 20

        //methods
        public static let photosSearchMethodValue = "flickr.photos.search"

        //response parmeter names
        public static let statFieldName = "stat"
        public static let messageFieldName = "message"
        public static let codeFieldName = "code"
        public static let photosFieldName = "photos"
        public static let photoFieldName = "photo"

        //response parmeter values
        public static let statFieldSuccessfulValue = "ok"
        public static let statFieldFailedValue = "fail"

    }

    public enum WebService {

        public static let defaultTimeoutInterval = 30.0
        public static let method = "POST"

    }

    public enum Error {

        public static let appErrorDomaion = "FlickrAppErrorDomain"
        public static let communicationError = -1009
        public static let generalError = -1
        public static let jsonParseError = -2

    }

    public enum FlickrPhoto {
        public static let idFieldName = "id"
        public static let ownerFieldName = "owner"
        public static let secretFieldName = "secret"
        public static let serverFieldName = "server"
        public static let farmFieldName = "farm"
        public static let titleFieldName = "title"
        public static let isFriendFieldName = "isfriend"
        public static let isFamilyFieldName = "isfamily"
        public static let isPublicFieldName = "ispublic"
    }

}

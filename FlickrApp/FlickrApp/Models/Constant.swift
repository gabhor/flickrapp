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
        public static let photoIdFieldName = "photo_id"
        public static let secretFieldName = "secret"

        //static request values
        public static let apiKey = "65803e8f6e4a3982200621cad356be51"
        public static let format = "json"
        public static let noJsonCallback = "1"

        //default request values
        public static let perPageDefaultValue = 20

        //methods
        public static let photosSearchMethodValue = "flickr.photos.search"
        public static let photosGetInfoMethodValue = "flickr.photos.getInfo"

        //response parmeter keys
        public static let statKey = "stat"
        public static let messageKey = "message"
        public static let codeKey = "code"

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
        public static let photosKey = "photos"
        public static let photoKey = "photo"
        public static let idKey = "id"
        public static let ownerKey = "owner"
        public static let secretKey = "secret"
        public static let serverKey = "server"
        public static let farmKey = "farm"
        public static let titleKey = "title"
        public static let descriptionKey = "description"
        public static let originalSecretKey = "originalsecret"
        public static let originalFormatKey = "originalformat"
        public static let userNameKey = "username"
        public static let realNameKey = "realname"
        public static let contentKey = "_content"
        public static let datesKey = "dates"
        public static let takenDateKey = "taken"
    }

}

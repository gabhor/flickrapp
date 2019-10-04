//
//  PhotosGetInfoService.swift
//  FlickrApp
//
//  Created by Gabor Horvath on 2019. 10. 03..
//  Copyright © 2019. Gabor Horvath. All rights reserved.
//

import Foundation

class PhotosGetInfoService : WebService {
    func getInfo(requestModel: PhotosGetInfo.RequestModel) {
        let deserializer = PhotosGetInfoDeserializer()
        processRequest(requestModel: requestModel, deserializer: deserializer)
    }
}

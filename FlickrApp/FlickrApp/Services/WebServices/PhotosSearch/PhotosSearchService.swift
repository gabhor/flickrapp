//
//  PhotosSearchService.swift
//  FlickrApp
//
//  Created by Gabor Horvath on 2019. 10. 01..
//  Copyright © 2019. Gabor Horvath. All rights reserved.
//

import Foundation

class PhotosSearchService : WebService {
    func search(requestModel: PhotosSearch.RequestModel) {
        let deserializer = PhotosSearchDeserializer()
        processRequest(requestModel: requestModel, deserializer: deserializer)
    }
}

//
//  PhotosGetInfoTest.swift
//  FlickrAppTests
//
//  Created by Gabor Horvath on 2019. 10. 07..
//  Copyright © 2019. Gabor Horvath. All rights reserved.
//

import XCTest

class PhotosGetInfoTest: XCTestCase {

    var sut: PhotosGetInfo.RequestModel!

    override func setUp() {
        super.setUp()
    }

    func testWithoutSecret() {
        // 1. given
        let photoId = "123456789"
        sut = PhotosGetInfo.RequestModel(photoId: photoId)

        // 2. when
        let result = sut.queryDataString()

        // 3. then
        XCTAssertTrue(result.contains("\(Constant.RequestParameter.apiKey)=\(Constant.FlickrService.apiKey)"))
        XCTAssertTrue(result.contains("\(Constant.RequestParameter.noJsonCallback)=\(Constant.FlickrService.noJsonCallback)"))
        XCTAssertTrue(result.contains("\(Constant.RequestParameter.method)=\(Constant.FlickrService.Method.photosGetInfo)"))
        XCTAssertTrue(result.contains("\(Constant.RequestParameter.format)=\(Constant.FlickrService.format)"))
        XCTAssertTrue(result.contains("\(Constant.RequestParameter.photoId)=\(photoId)"))
        XCTAssertTrue(!result.contains("\(Constant.RequestParameter.secret)="))
    }

    func testWithSecret() {
        // 1. given
        let photoId = "123456789"
        let secret = "9876543210"
        sut = PhotosGetInfo.RequestModel(photoId: photoId, secret: secret)

        // 2. when
        let result = sut.queryDataString()

        // 3. then
        XCTAssertTrue(result.contains("\(Constant.RequestParameter.apiKey)=\(Constant.FlickrService.apiKey)"))
        XCTAssertTrue(result.contains("\(Constant.RequestParameter.noJsonCallback)=\(Constant.FlickrService.noJsonCallback)"))
        XCTAssertTrue(result.contains("\(Constant.RequestParameter.method)=\(Constant.FlickrService.Method.photosGetInfo)"))
        XCTAssertTrue(result.contains("\(Constant.RequestParameter.format)=\(Constant.FlickrService.format)"))
        XCTAssertTrue(result.contains("\(Constant.RequestParameter.photoId)=\(photoId)"))
        XCTAssertTrue(result.contains("\(Constant.RequestParameter.secret)=\(secret)"))
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
}

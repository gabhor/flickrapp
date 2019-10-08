//
//  PhotosGetInfoServiceTest.swift
//  FlickrAppTests
//
//  Created by Gabor Horvath on 2019. 10. 08..
//  Copyright © 2019. Gabor Horvath. All rights reserved.
//

import XCTest

class PhotosGetInfoServiceTest: XCTestCase {

    var sut = PhotosGetInfoService()
    let spyDelegate = SpyDelegate()

    override func setUp() {
        super.setUp()
        sut.delegate = spyDelegate
        let asyncExpectation = expectation(description: "PhotosSearchService calls the delegate as the result of an async method completion")
        spyDelegate.asyncExpectation = asyncExpectation
    }

    func testWithValidPhotoIdData() {
        // 1. given
        let requestModel = PhotosGetInfo.RequestModel(photoId: "48866389302")

        // 2. when
        sut.getInfo(requestModel: requestModel)

        // 3. then
        waitForExpectations(timeout: 2) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }

            guard let result = self.spyDelegate.response else {
                XCTFail("Expected delegate to be called")
                return
            }

            XCTAssertTrue(result.stat == Constant.FlickrService.Result.successful)
        }
    }

    func testWithFakePhotoIdData() {
        // 1. given
        let requestModel = PhotosGetInfo.RequestModel(photoId: "12345")

        // 2. when
        sut.getInfo(requestModel: requestModel)

        // 3. then
        waitForExpectations(timeout: 2) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }

            guard let serviceError = self.spyDelegate.error else {
                XCTFail("Expected delegate to be called")
                return
            }

            XCTAssertTrue((serviceError as NSError).domain == Constant.Error.Domain.photosGetInfoService)
            XCTAssertTrue((serviceError as NSError).code == 1)
        }
    }

    override func tearDown() {
        super.tearDown()
    }
}


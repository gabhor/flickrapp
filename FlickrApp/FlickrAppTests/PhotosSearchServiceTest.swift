//
//  PhotosSearchServiceTest.swift
//  FlickrAppTests
//
//  Created by Gabor Horvath on 2019. 10. 08..
//  Copyright © 2019. Gabor Horvath. All rights reserved.
//

import XCTest

class SpyDelegate: WebServiceDelegate {
    var response: ResponseModelProtocol? = .none
    var error: Error? = .none

    var asyncExpectation: XCTestExpectation?

    func serviceFinished(withResponse response: ResponseModelProtocol) {
        guard let expectation = asyncExpectation else {
          XCTFail("SpyDelegate was not setup correctly. Missing XCTExpectation reference")
          return
        }
        self.response = response
        expectation.fulfill()
    }

    func serviceFinished(withError error: Error) {
        guard let expectation = asyncExpectation else {
          XCTFail("SpyDelegate was not setup correctly. Missing XCTExpectation reference")
          return
        }
        self.error = error
        expectation.fulfill()
    }
}

class PhotosSearchServiceTest: XCTestCase {

    var sut = PhotosSearchService()
    let spyDelegate = SpyDelegate()

    override func setUp() {
        super.setUp()
        sut.delegate = spyDelegate
        let asyncExpectation = expectation(description: "PhotosSearchService calls the delegate as the result of an async method completion")
        spyDelegate.asyncExpectation = asyncExpectation
    }

    func testWithValidData() {
        // 1. given
        let requestModel = PhotosSearch.RequestModel(text: "dog")

        // 2. when
        sut.search(requestModel: requestModel)

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

    override func tearDown() {
        super.tearDown()
    }
}


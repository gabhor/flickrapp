//
//  PhotosSearchTest.swift
//  FlickrAppTests
//
//  Created by Gabor Horvath on 2019. 10. 07..
//  Copyright © 2019. Gabor Horvath. All rights reserved.
//

import XCTest

class PhotosSearchTest: XCTestCase {

    var sut: PhotosSearch.RequestModel!

    override func setUp() {
        super.setUp()
    }

    func testWithDefaultPaging() {
        // 1. given
        let keyword = "test"
        sut = PhotosSearch.RequestModel(text: keyword)

        // 2. when
        let result = sut.queryDataString()

        // 3. then
        XCTAssertTrue(result.contains("\(Constant.RequestParameter.apiKey)=\(Constant.FlickrService.apiKey)"))
        XCTAssertTrue(result.contains("\(Constant.RequestParameter.perPage)=\(Constant.App.perPageDefaultValue)"))
        XCTAssertTrue(!result.contains("&\(Constant.RequestParameter.page)="))
        XCTAssertTrue(result.contains("\(Constant.RequestParameter.noJsonCallback)=\(Constant.FlickrService.noJsonCallback)"))
        XCTAssertTrue(result.contains("\(Constant.RequestParameter.method)=\(Constant.FlickrService.Method.photosSearch)"))
        XCTAssertTrue(result.contains("\(Constant.RequestParameter.media)=\(Constant.FlickrService.media)"))
        XCTAssertTrue(result.contains("\(Constant.RequestParameter.format)=\(Constant.FlickrService.format)"))
        XCTAssertTrue(result.contains("\(Constant.RequestParameter.text)=\(keyword)"))
    }

    func testWithCustomPaging() {
        // 1. given
        let keyword = "test"
        let perPage = 15
        let page = 3
        sut = PhotosSearch.RequestModel(text: keyword, perPage: perPage, page: page)

        // 2. when
        let result = sut.queryDataString()

        // 3. then
        XCTAssertTrue(result.contains("\(Constant.RequestParameter.apiKey)=\(Constant.FlickrService.apiKey)"))
        XCTAssertTrue(result.contains("\(Constant.RequestParameter.perPage)=\(perPage)"))
        XCTAssertTrue(result.contains("&\(Constant.RequestParameter.page)=\(page)"))
        XCTAssertTrue(result.contains("\(Constant.RequestParameter.noJsonCallback)=\(Constant.FlickrService.noJsonCallback)"))
        XCTAssertTrue(result.contains("\(Constant.RequestParameter.method)=\(Constant.FlickrService.Method.photosSearch)"))
        XCTAssertTrue(result.contains("\(Constant.RequestParameter.media)=\(Constant.FlickrService.media)"))
        XCTAssertTrue(result.contains("\(Constant.RequestParameter.format)=\(Constant.FlickrService.format)"))
        XCTAssertTrue(result.contains("\(Constant.RequestParameter.text)=\(keyword)"))
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
}

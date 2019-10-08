//
//  FlickrPhotoDetailsTest.swift
//  FlickrAppTests
//
//  Created by Gabor Horvath on 2019. 10. 07..
//  Copyright © 2019. Gabor Horvath. All rights reserved.
//

import XCTest

class FlickrPhotoDetailsTest: XCTestCase {

    var sut: FlickrPhotoDetails!
    let photoId = "11111111"
    let secret = "22222222"
    let server = "3333"
    let farm = 44
    let originalSecret = "55555555"
    let originalFormat = "jpg"

    override func setUp() {
        super.setUp()
    }

    func testUrlsWithValidData() {
        // 1. given
        sut = FlickrPhotoDetails(photoId: photoId, secret: secret, server: server, farm: farm, originalSecret: originalSecret, originalFormat: originalFormat, ownerUserName: nil, ownerRealName: nil, title: nil, description: nil, taken: nil)

        // 2. when
        let largeImageUrl = sut.largeImageUrl()
        let originalImageUrl = sut.originalImageUrl()

        // 3. then
        XCTAssertEqual(largeImageUrl, "https://farm44.staticflickr.com/3333/11111111_22222222_b.jpg")
        XCTAssertEqual(originalImageUrl, "https://farm44.staticflickr.com/3333/11111111_55555555_o.jpg)")
    }

    func testUrlsWithoutPhotoId() {
        // 1. given
        sut = FlickrPhotoDetails(photoId: nil, secret: secret, server: server, farm: farm, originalSecret: originalSecret, originalFormat: originalFormat, ownerUserName: nil, ownerRealName: nil, title: nil, description: nil, taken: nil)

        // 2. when
        let largeImageUrl = sut.largeImageUrl()
        let originalImageUrl = sut.originalImageUrl()

        // 3. then
        XCTAssertNil(largeImageUrl)
        XCTAssertNil(originalImageUrl)
    }

    func testUrlsWithoutSecret() {
        // 1. given
        sut = FlickrPhotoDetails(photoId: photoId, secret: nil, server: server, farm: farm, originalSecret: originalSecret, originalFormat: originalFormat, ownerUserName: nil, ownerRealName: nil, title: nil, description: nil, taken: nil)

        // 2. when
        let largeImageUrl = sut.largeImageUrl()
        let originalImageUrl = sut.originalImageUrl()

        // 3. then
        XCTAssertNil(largeImageUrl)
        XCTAssertEqual(originalImageUrl, "https://farm44.staticflickr.com/3333/11111111_55555555_o.jpg)")
    }

    func testUrlsWithoutServer() {
        // 1. given
        sut = FlickrPhotoDetails(photoId: photoId, secret: secret, server: nil, farm: farm, originalSecret: originalSecret, originalFormat: originalFormat, ownerUserName: nil, ownerRealName: nil, title: nil, description: nil, taken: nil)

        // 2. when
        let largeImageUrl = sut.largeImageUrl()
        let originalImageUrl = sut.originalImageUrl()

        // 3. then
        XCTAssertNil(largeImageUrl)
        XCTAssertNil(originalImageUrl)
    }

    func testUrlsWithoutFarm() {
        // 1. given
        sut = FlickrPhotoDetails(photoId: photoId, secret: secret, server: server, farm: nil, originalSecret: originalSecret, originalFormat: originalFormat, ownerUserName: nil, ownerRealName: nil, title: nil, description: nil, taken: nil)

        // 2. when
        let largeImageUrl = sut.largeImageUrl()
        let originalImageUrl = sut.originalImageUrl()

        // 3. then
        XCTAssertNil(largeImageUrl)
        XCTAssertNil(originalImageUrl)
    }

    func testUrlsWithoutOriginalSecret() {
        // 1. given
        sut = FlickrPhotoDetails(photoId: photoId, secret: secret, server: server, farm: farm, originalSecret: nil, originalFormat: originalFormat, ownerUserName: nil, ownerRealName: nil, title: nil, description: nil, taken: nil)

        // 2. when
        let largeImageUrl = sut.largeImageUrl()
        let originalImageUrl = sut.originalImageUrl()

        // 3. then
        XCTAssertEqual(largeImageUrl, "https://farm44.staticflickr.com/3333/11111111_22222222_b.jpg")
        XCTAssertNil(originalImageUrl)
    }

    func testUrlsWithoutOriginalFormat() {
        // 1. given
        sut = FlickrPhotoDetails(photoId: photoId, secret: secret, server: server, farm: farm, originalSecret: originalSecret, originalFormat: nil, ownerUserName: nil, ownerRealName: nil, title: nil, description: nil, taken: nil)

        // 2. when
        let largeImageUrl = sut.largeImageUrl()
        let originalImageUrl = sut.originalImageUrl()

        // 3. then
        XCTAssertEqual(largeImageUrl, "https://farm44.staticflickr.com/3333/11111111_22222222_b.jpg")
        XCTAssertNil(originalImageUrl)
    }


    override func tearDown() {
        sut = nil
        super.tearDown()
    }
}

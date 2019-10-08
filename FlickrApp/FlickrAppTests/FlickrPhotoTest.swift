//
//  FlickrPhotoTest.swift
//  FlickrAppTests
//
//  Created by Gabor Horvath on 2019. 10. 07..
//  Copyright © 2019. Gabor Horvath. All rights reserved.
//

import XCTest

class FlickrPhotoTest: XCTestCase {

    var sut: FlickrPhoto!
    let photoId = "11111111"
    let secret = "22222222"
    let server = "3333"
    let farm = 44

    override func setUp() {
        super.setUp()
    }

    func testThumbnailUrlWithValidData() {
        // 1. given
        sut = FlickrPhoto(photoId: photoId, owner: nil, secret: secret, server: server, farm: farm, title: nil)

        // 2. when
        let result = sut.thumbnailUrl()

        // 3. then
        XCTAssertEqual(result, "https://farm44.staticflickr.com/3333/11111111_22222222_m.jpg")
    }

    func testThumbnailUrlWithoutPhotoId() {
        // 1. given
        sut = FlickrPhoto(photoId: nil, owner: nil, secret: secret, server: server, farm: farm, title: nil)

        // 2. when
        let result = sut.thumbnailUrl()

        // 3. then
        XCTAssertNil(result)
    }

    func testThumbnailUrlWithoutSecret() {
        // 1. given
        sut = FlickrPhoto(photoId: photoId, owner: nil, secret: nil, server: server, farm: farm, title: nil)

        // 2. when
        let result = sut.thumbnailUrl()

        // 3. then
        XCTAssertNil(result)
    }

    func testThumbnailUrlWithoutServer() {
        // 1. given
        sut = FlickrPhoto(photoId: photoId, owner: nil, secret: secret, server: nil, farm: farm, title: nil)

        // 2. when
        let result = sut.thumbnailUrl()

        // 3. then
        XCTAssertNil(result)
    }

    func testThumbnailUrlWithoutFarm() {
        // 1. given
        sut = FlickrPhoto(photoId: photoId, owner: nil, secret: secret, server: server, farm: nil, title: nil)

        // 2. when
        let result = sut.thumbnailUrl()

        // 3. then
        XCTAssertNil(result)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
}

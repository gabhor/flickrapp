//
//  AppDataServiceTest.swift
//  FlickrAppTests
//
//  Created by Gabor Horvath on 2019. 10. 07..
//  Copyright © 2019. Gabor Horvath. All rights reserved.
//

import XCTest

class AppDataServiceTest: XCTestCase {
    var sut: AppDataService!

    override func setUp() {
        super.setUp()
        sut = AppDataService.shared
    }

    func testWithValidText() {
        // 1. given
        sut.storeSearchKeyword("cat")

        // 2. when
        let result = sut.getStoredSearchKeyword()

        // 3. then
        XCTAssertEqual(result, "cat", "Wrong keyword")
    }

    func testWithEmptyString() {
        // 1. given
        sut.storeSearchKeyword("")

        // 2. when
        let result = sut.getStoredSearchKeyword()

        // 3. then
        XCTAssertEqual(result, Constant.App.initialSearchText, "Wrong keyword")
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
}

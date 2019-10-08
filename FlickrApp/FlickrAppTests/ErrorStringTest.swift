//
//  ErrorStringTest.swift
//  FlickrAppTests
//
//  Created by Gabor Horvath on 2019. 10. 08..
//  Copyright © 2019. Gabor Horvath. All rights reserved.
//

import XCTest

class ErrorStringTest: XCTestCase {

    var errorMessage = String()

    func testCommunicationError() {
        errorMessage = NSError(domain: Constant.Error.Domain.communication, code: 1, userInfo: nil).message()
        XCTAssertTrue(errorMessage.contains("communicationError".localized))
    }

    func testAppErrors() {
        errorMessage = NSError(domain: Constant.Error.Domain.app, code: Constant.Error.Code.generalError, userInfo: nil).message()
        XCTAssertTrue(errorMessage.contains("generalError".localized))

        errorMessage = NSError(domain: Constant.Error.Domain.app, code: Constant.Error.Code.communicationError, userInfo: nil).message()
        XCTAssertTrue(errorMessage.contains("communicationError".localized))

        errorMessage = NSError(domain: Constant.Error.Domain.app, code: Constant.Error.Code.generalError, userInfo: nil).message()
        XCTAssertTrue(errorMessage.contains("generalError".localized))

        errorMessage = NSError(domain: Constant.Error.Domain.app, code: Constant.Error.Code.jsonParseError, userInfo: nil).message()
        XCTAssertTrue(errorMessage.contains("responseError".localized))

        errorMessage = NSError(domain: Constant.Error.Domain.app, code: Constant.Error.Code.jsonStructError, userInfo: nil).message()
        XCTAssertTrue(errorMessage.contains("responseError".localized))

        errorMessage = NSError(domain: Constant.Error.Domain.app, code: Constant.Error.Code.emptyResponseError, userInfo: nil).message()
        XCTAssertTrue(errorMessage.contains("responseError".localized))

        errorMessage = NSError(domain: Constant.Error.Domain.app, code: 12345, userInfo: nil).message()
        XCTAssertTrue(errorMessage.contains("generalError".localized))
    }

    func testPhotosSearchServiceErrors() {
        errorMessage = NSError(domain: Constant.Error.Domain.photosSearchService, code: 1, userInfo: nil).message()
        XCTAssertTrue(errorMessage.contains("requestError".localized))

        errorMessage = NSError(domain: Constant.Error.Domain.photosSearchService, code: 2, userInfo: nil).message()
        XCTAssertTrue(errorMessage.contains("unknownUserError".localized))

        errorMessage = NSError(domain: Constant.Error.Domain.photosSearchService, code: 3, userInfo: nil).message()
        XCTAssertTrue(errorMessage.contains("requestError".localized))

        errorMessage = NSError(domain: Constant.Error.Domain.photosSearchService, code: 4, userInfo: nil).message()
        XCTAssertTrue(errorMessage.contains("requestError".localized))

        errorMessage = NSError(domain: Constant.Error.Domain.photosSearchService, code: 5, userInfo: nil).message()
        XCTAssertTrue(errorMessage.contains("unknownUserError".localized))

        errorMessage = NSError(domain: Constant.Error.Domain.photosSearchService, code: 10, userInfo: nil).message()
        XCTAssertTrue(errorMessage.contains("serviceUnavailable".localized))

        errorMessage = NSError(domain: Constant.Error.Domain.photosSearchService, code: 11, userInfo: nil).message()
        XCTAssertTrue(errorMessage.contains("requestErrorv".localized))

        errorMessage = NSError(domain: Constant.Error.Domain.photosSearchService, code: 12, userInfo: nil).message()
        XCTAssertTrue(errorMessage.contains("requestError".localized))

        errorMessage = NSError(domain: Constant.Error.Domain.photosSearchService, code: 17, userInfo: nil).message()
        XCTAssertTrue(errorMessage.contains("requestError".localized))

        errorMessage = NSError(domain: Constant.Error.Domain.photosSearchService, code: 18, userInfo: nil).message()
        XCTAssertTrue(errorMessage.contains("requestError".localized))

        errorMessage = NSError(domain: Constant.Error.Domain.photosSearchService, code: 99, userInfo: nil).message()
        XCTAssertTrue(errorMessage.contains("generalError".localized))
        
        errorMessage = NSError(domain: Constant.Error.Domain.photosGetInfoService, code: 100, userInfo: nil).message()
        XCTAssertTrue(errorMessage.contains("requestError".localized))

        errorMessage = NSError(domain: Constant.Error.Domain.photosGetInfoService, code: 105, userInfo: nil).message()
        XCTAssertTrue(errorMessage.contains("serviceUnavailable".localized))

        errorMessage = NSError(domain: Constant.Error.Domain.photosGetInfoService, code: 106, userInfo: nil).message()
        XCTAssertTrue(errorMessage.contains("serviceUnavailable".localized))

        errorMessage = NSError(domain: Constant.Error.Domain.photosGetInfoService, code: 111, userInfo: nil).message()
        XCTAssertTrue(errorMessage.contains("communicationError".localized))

        errorMessage = NSError(domain: Constant.Error.Domain.photosGetInfoService, code: 112, userInfo: nil).message()
        XCTAssertTrue(errorMessage.contains("communicationError".localized))

        errorMessage = NSError(domain: Constant.Error.Domain.photosGetInfoService, code: 114, userInfo: nil).message()
        XCTAssertTrue(errorMessage.contains("communicationError".localized))

        errorMessage = NSError(domain: Constant.Error.Domain.photosGetInfoService, code: 115, userInfo: nil).message()
        XCTAssertTrue(errorMessage.contains("communicationError".localized))

        errorMessage = NSError(domain: Constant.Error.Domain.photosGetInfoService, code: 116, userInfo: nil).message()
        XCTAssertTrue(errorMessage.contains("communicationError".localized))

        errorMessage = NSError(domain: Constant.Error.Domain.photosGetInfoService, code: 999, userInfo: nil).message()
        XCTAssertTrue(errorMessage.contains("generalError".localized))
    }

    func testPhotosGetInfoServiceErrors() {
        errorMessage = NSError(domain: Constant.Error.Domain.photosGetInfoService, code: 1, userInfo: nil).message()
        XCTAssertTrue(errorMessage.contains("photoNotFound".localized))

        errorMessage = NSError(domain: Constant.Error.Domain.photosGetInfoService, code: 99, userInfo: nil).message()
        XCTAssertTrue(errorMessage.contains("generalError".localized))

        errorMessage = NSError(domain: Constant.Error.Domain.photosGetInfoService, code: 100, userInfo: nil).message()
        XCTAssertTrue(errorMessage.contains("requestError".localized))

        errorMessage = NSError(domain: Constant.Error.Domain.photosGetInfoService, code: 105, userInfo: nil).message()
        XCTAssertTrue(errorMessage.contains("serviceUnavailable".localized))

        errorMessage = NSError(domain: Constant.Error.Domain.photosGetInfoService, code: 106, userInfo: nil).message()
        XCTAssertTrue(errorMessage.contains("serviceUnavailable".localized))

        errorMessage = NSError(domain: Constant.Error.Domain.photosGetInfoService, code: 111, userInfo: nil).message()
        XCTAssertTrue(errorMessage.contains("communicationError".localized))

        errorMessage = NSError(domain: Constant.Error.Domain.photosGetInfoService, code: 112, userInfo: nil).message()
        XCTAssertTrue(errorMessage.contains("communicationError".localized))

        errorMessage = NSError(domain: Constant.Error.Domain.photosGetInfoService, code: 114, userInfo: nil).message()
        XCTAssertTrue(errorMessage.contains("communicationError".localized))

        errorMessage = NSError(domain: Constant.Error.Domain.photosGetInfoService, code: 115, userInfo: nil).message()
        XCTAssertTrue(errorMessage.contains("communicationError".localized))

        errorMessage = NSError(domain: Constant.Error.Domain.photosGetInfoService, code: 116, userInfo: nil).message()
        XCTAssertTrue(errorMessage.contains("communicationError".localized))

        errorMessage = NSError(domain: Constant.Error.Domain.photosGetInfoService, code: 999, userInfo: nil).message()
        XCTAssertTrue(errorMessage.contains("generalError".localized))
    }
}

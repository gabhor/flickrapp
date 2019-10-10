//
//  LogService.swift
//  FlickrApp
//
//  Created by Gabor Horvath on 2019. 10. 06..
//  Copyright © 2019. Gabor Horvath. All rights reserved.
//

import Foundation

class LogService {
    static let shared = LogService()

    func fatal(_ string: String) {
        log(string: string, requiredLogLevel: .fatal)
    }

    func error(_ string: String) {
        log(string: string, requiredLogLevel: .error)
    }

    func warn(_ string: String) {
        log(string: string, requiredLogLevel: .warn)
    }

    func info(_ string: String) {
        log(string: string, requiredLogLevel: .info)
    }

    func debug(_ string: String) {
        log(string: string, requiredLogLevel: .debug)
    }

    func trace(_ string: String) {
        log(string: string, requiredLogLevel: .trace)
    }
}

// MARK: - Private extension

private extension LogService {
    func log(string: String, requiredLogLevel: LogLevel) {
        if Constant.App.logLevel.rawValue >= requiredLogLevel.rawValue {
            print("[\(Constant.App.appName))][\(requiredLogLevel.stringValue)]: \(string)")
        }
    }
}

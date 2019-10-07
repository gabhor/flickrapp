//
//  LogLevel.swift
//  FlickrApp
//
//  Created by Gabor Horvath on 2019. 10. 06..
//  Copyright © 2019. Gabor Horvath. All rights reserved.
//

import Foundation

public enum LogLevel: Int {
    public typealias RawValue = Int

    case off = 0
    case fatal = 1
    case error = 2
    case warn = 3
    case info = 4
    case debug = 5
    case trace = 6
    case all = 7

    public var stringValue: String {
        switch self {
            case .off:
                return "off"
            case .fatal:
                return "fatal"
            case .error:
                return "error"
            case .warn:
                return "warn"
            case .info:
                return "info"
            case .debug:
                return "debug"
            case .trace:
                return "trace"
            case .all:
                return "all"
        }
    }
}

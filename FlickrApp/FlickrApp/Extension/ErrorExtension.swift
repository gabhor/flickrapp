//
//  ErrorExtension.swift
//  FlickrApp
//
//  Created by Gabor Horvath on 2019. 10. 07..
//  Copyright © 2019. Gabor Horvath. All rights reserved.
//

import Foundation

extension Error {
    
    func message() -> String {
        let errorDomain = (self as NSError).domain
        let errorCode = (self as NSError).code
        var errorString = "unknownError".localized
        if errorDomain == Constant.Error.Domain.communication {
            errorString = "communicationError".localized
        } else if errorDomain == Constant.Error.Domain.app {
            errorString = appErrorString(for: errorCode)
        } else if errorDomain == Constant.Error.Domain.photosSearchService {
            errorString = photosSearchErrorString(for: errorCode)
        } else if errorDomain == Constant.Error.Domain.photosGetInfoService {
            errorString = getInfoErrorString(for: errorCode)
        }
//        if let message = (self as NSError).userInfo[Constant.Error.serviceMessageKey] as? String {
//            return message
//        }
        return "\(errorString)\n(\(errorCode))"
    }

    private func appErrorString(for errorCode: Int) -> String {
        switch errorCode {
            case Constant.Error.Code.communicationError:
                return "communicationError".localized
            case Constant.Error.Code.generalError:
                return "generalError".localized
            case Constant.Error.Code.jsonParseError:
                return "responseError".localized
            case Constant.Error.Code.jsonStructError:
                return "responseError".localized
            case Constant.Error.Code.emptyResponseError:
                return "responseError".localized
            default:
                return "generalError".localized
        }
    }

    private func serviceErrorString(for errorCode: Int) -> String {
        switch errorCode {
        case 100:
            return "requestError".localized
        case 105:
            return "serviceUnavailable".localized
        case 106:
            return "serviceUnavailable".localized
        case 111:
            return "communicationError".localized
        case 112:
            return "communicationError".localized
        case 114:
            return "communicationError".localized
        case 115:
            return "communicationError".localized
        case 116:
            return "communicationError".localized
        default:
            return "generalError".localized
        }
    }

    private func photosSearchErrorString(for errorCode: Int) -> String {
        if errorCode >= Constant.Error.serviceGeneralErrorTreshold {
            return serviceErrorString(for: errorCode)
        }
        switch errorCode {
        case 1:
            return "requestError".localized
        case 2:
            return "unknownUserError".localized
        case 3:
            return "requestError".localized
        case 4:
            return "requestError".localized
        case 5:
            return "unknownUserError".localized
        case 10:
            return "serviceUnavailable".localized
        case 11:
            return "requestErrorv".localized
        case 12:
            return "requestError".localized
        case 17:
            return "requestError".localized
        case 18:
            return "requestError".localized
        default:
            return "generalError".localized
        }
    }

    private func getInfoErrorString(for errorCode: Int) -> String {
        if errorCode >= Constant.Error.serviceGeneralErrorTreshold {
            return serviceErrorString(for: errorCode)
        }
        switch errorCode {
        case 1:
            return "photoNotFound".localized
        default:
            return "generalError".localized
        }
    }
}

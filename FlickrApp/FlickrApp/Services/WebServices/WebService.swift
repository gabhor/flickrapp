//
//  WebService.swift
//  FlickrApp
//
//  Created by Gabor Horvath on 2019. 10. 01..
//  Copyright © 2019. Gabor Horvath. All rights reserved.
//

import Foundation

class WebService {
    weak var delegate: WebServiceDelegate?

    func processRequest(requestModel: RequestModelProtocol, deserializer: ResponseDeserializerProtocol) {
        guard let requestUrl = URL(string: Constant.FlickrService.restServiceUrl) else { return }
        if Constant.App.isLogEnabled {
            print("[FLICKR APP] requestUrl: \(requestUrl)")
        }
        let urlRequest = postUrlRequest(requestUrl: requestUrl, postDataString: requestModel.queryDataString())
        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in

            guard let strongSelf = self else { return }

            if Constant.App.isLogEnabled, let response = response {
                print("[FLICKR APP] response: \(response)")
            }

            if let error = error {
                if Constant.App.isLogEnabled {
                    print("[FLICKR APP] error: \(error)")
                }
                strongSelf.handleError(error: error as NSError)
                return
            }

            guard let data = data else {
                let error = NSError(domain: Constant.Error.appErrorDomaion, code: (response as? HTTPURLResponse)?.statusCode ?? Constant.Error.generalError, userInfo: .none)
                strongSelf.handleError(error: error)
                return
            }

            guard let httpUrlResponse = response as? HTTPURLResponse, httpUrlResponse.statusCode == 200 else {
                let error = NSError(domain: Constant.Error.appErrorDomaion, code: (response as? HTTPURLResponse)?.statusCode ?? Constant.Error.generalError, userInfo: .none)
                strongSelf.handleError(error: error)
                return
            }

            do {
                if Constant.App.isLogEnabled {
                    print("[FLICKR APP] string response: \(String(data: data, encoding: .utf8) ?? "-")")
                }

                let jsonData = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
                if Constant.App.isLogEnabled {
                    print("[FLICKR APP] json response: \(jsonData)")
                }
                let responseModel = deserializer.responseModel(fromJsonData: jsonData)
                if responseModel.stat == Constant.FlickrService.Result.successful {
                    strongSelf.delegate?.serviceFinished(withResponse: responseModel)
                } else {
                    // Process error
                }
            } catch _ as NSError {
                let error = NSError(domain: Constant.Error.appErrorDomaion, code: (response as? HTTPURLResponse)?.statusCode ?? Constant.Error.jsonParseError, userInfo: .none)
                strongSelf.handleError(error: error)
            }
        }

        task.resume()
    }
}

private extension WebService {

    func postUrlRequest(requestUrl: URL, postDataString: String) -> URLRequest {
        var urlRequest = URLRequest(url: requestUrl, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: Constant.WebService.defaultTimeoutInterval)
        urlRequest.httpMethod = Constant.WebService.method
        urlRequest.httpBody = postDataString.data(using: .utf8)

        return urlRequest
    }

    func handleError(error: NSError) {

        if error.code == Constant.Error.communicationError {
            // Process error
        } else {
            delegate?.serviceFinished(withError: error)
        }
    }
}

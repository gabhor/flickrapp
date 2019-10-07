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
        LogService.shared.debug("requestUrl: \(requestUrl)")
        let urlRequest = postUrlRequest(requestUrl: requestUrl, postDataString: requestModel.queryDataString())
        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
            guard let strongSelf = self else { return }

            if let response = response {
                LogService.shared.trace("response: \(response)")
            }
            if let error = error {
                strongSelf.handleError(error: error as NSError)
                return
            }
            strongSelf.processHttpResponse(data: data, response: response, deserializer: deserializer)
        }

        task.resume()
    }
}

// MARK: - Private extension

private extension WebService {

    func postUrlRequest(requestUrl: URL, postDataString: String) -> URLRequest {
        var urlRequest = URLRequest(url: requestUrl, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: Constant.WebService.defaultTimeoutInterval)
        urlRequest.httpMethod = Constant.WebService.method
        urlRequest.httpBody = postDataString.data(using: .utf8)

        return urlRequest
    }

    func processHttpResponse(data: Data?, response: URLResponse?, deserializer: ResponseDeserializerProtocol) {
        guard let data = data else {
            let error = NSError(domain: Constant.Error.Domain.communication, code: (response as? HTTPURLResponse)?.statusCode ?? Constant.Error.Code.generalError, userInfo: .none)
            handleError(error: error)
            return
        }

        guard let httpUrlResponse = response as? HTTPURLResponse, httpUrlResponse.statusCode == 200 else {
            let error = NSError(domain: Constant.Error.Domain.communication, code: (response as? HTTPURLResponse)?.statusCode ?? Constant.Error.Code.generalError, userInfo: .none)
            handleError(error: error)
            return
        }

        processJsonData(data: data, deserializer: deserializer)
    }

    func processJsonData(data: Data, deserializer: ResponseDeserializerProtocol) {
        do {
            LogService.shared.debug("string response: \(String(data: data, encoding: .utf8) ?? "-")")

            let jsonData = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
            LogService.shared.info("json response: \(jsonData)")
            let responseModel = deserializer.responseModel(fromJsonData: jsonData)
            if responseModel.stat == Constant.FlickrService.Result.successful {
                delegate?.serviceFinished(withResponse: responseModel)
            } else {
                if let error = responseModel.error {
                    handleError(error: error)
                }
            }
        } catch _ as NSError {
            let error = NSError(domain: Constant.Error.Domain.app, code: Constant.Error.Code.jsonParseError, userInfo: .none)
            handleError(error: error)
        }

    }

    func handleError(error: NSError) {
        LogService.shared.error("error: \(error)")
        delegate?.serviceFinished(withError: error)
    }
}

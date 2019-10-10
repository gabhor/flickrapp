//
//  ImageDetailsPresenter.swift
//  FlickrApp
//
//  Created by Gabor Horvath on 2019. 10. 03..
//  Copyright © 2019. Gabor Horvath. All rights reserved.
//

import Foundation

class ImageDetailsPresenter {
    weak var view: ImageDetailsViewProtocol?
    let photoInfoService = PhotosGetInfoService()

    init() {
        photoInfoService.delegate = self
    }

    func getDetails(with photoId: String, secret: String) {
        let requestModel = PhotosGetInfo.RequestModel(photoId: photoId, secret: secret)
        photoInfoService.getInfo(requestModel: requestModel)
    }
}

// MARK: - WebServiceDelegate

extension ImageDetailsPresenter : WebServiceDelegate {
    func serviceFinished(withResponse response: ResponseModelProtocol) {
        guard let response = response as? PhotosGetInfo.ResponseModel else { return }

        if let photoDetails = response.photoDetails {
            view?.update(with: photoDetails)
        } else {
            let error = NSError(domain: Constant.Error.Domain.app, code: Constant.Error.Code.emptyResponseError, userInfo: .none)
            view?.update(with: error)
        }
    }

    func serviceFinished(withError error: Error) {
        view?.update(with: error)
    }
}

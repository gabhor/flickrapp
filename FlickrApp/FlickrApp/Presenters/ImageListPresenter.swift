//
//  ImageListPresenter.swift
//  FlickrApp
//
//  Created by Gabor Horvath on 2019. 10. 03..
//  Copyright © 2019. Gabor Horvath. All rights reserved.
//

import Foundation

class ImageListPresenter {
    weak var view: ImageListViewProtocol?
    let photoSearchService = PhotosSearchService()

    init() {
        photoSearchService.delegate = self
    }

    func startSearch(with keyword: String, page: Int = 1) {
        let requestModel = PhotosSearch.RequestModel(text: keyword, page: page)
        photoSearchService.search(requestModel: requestModel)
    }
}

extension ImageListPresenter : WebServiceDelegate {
    func serviceFinished(withResponse response: ResponseModelProtocol) {
        guard let response = response as? PhotosSearch.ResponseModel else { return }

        view?.update(with: response.photos ?? [])
    }

    func serviceFinished(withError error: Error) {
        view?.update(with: error)
    }
}

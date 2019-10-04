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
    private var photos = [FlickrPhoto]()
    private var lastKeyword: String?
    private var isLoading = false
    let photoSearchService = PhotosSearchService()

    init() {
        photoSearchService.delegate = self
    }

    func startSearch(with keyword: String) {
        guard !isLoading else { return }

        photos = [FlickrPhoto]()
        lastKeyword = keyword
        AppDataService.shared.storeSearchKeyword(keyword)
        view?.refresh()
        fetchImageList(with: keyword)
    }

    func loadNextPage() {
        guard !isLoading else { return }

        if let lastKeyword = lastKeyword {
            fetchImageList(with: lastKeyword)
        }
    }

    func numberOfPhotos() -> Int {
        return photos.count
    }

    func photo(at index: Int) -> FlickrPhoto? {
        if index < photos.count {
            return photos[index]
        }

        return .none
    }

    func initialSearchText() -> String {
        return AppDataService.shared.getStoredSearchKeyword()
    }
}

extension ImageListPresenter : WebServiceDelegate {
    func serviceFinished(withResponse response: ResponseModelProtocol) {
        isLoading = false
        guard let response = response as? PhotosSearch.ResponseModel else { return }
        if let photoList = response.photos {
            photos.append(contentsOf: photoList)
        }
        view?.refresh()
    }

    func serviceFinished(withError error: Error) {
        isLoading = false
        view?.update(with: error)
    }
}

private extension ImageListPresenter {
    func fetchImageList(with keyword: String) {
        guard keyword.count > 0 else { return }
        isLoading = true
        let page = Int(ceil(Double(photos.count)/Double(Constant.App.perPageDefaultValue)))
        let requestModel = PhotosSearch.RequestModel(text: keyword, page: page+1)
        photoSearchService.search(requestModel: requestModel)
    }

    func isLoading(_ loading: Bool) {
        isLoading = loading
        view?.isLoading(loading)
    }

}

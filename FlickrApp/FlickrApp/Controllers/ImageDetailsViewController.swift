//
//  ImageDetailsViewController.swift
//  FlickrApp
//
//  Created by Gabor Horvath on 2019. 10. 01..
//  Copyright © 2019. Gabor Horvath. All rights reserved.
//

import UIKit

class ImageDetailsViewController: UIViewController {

    private var presenter = ImageDetailsPresenter()
    var detailItem: FlickrPhoto?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        fetchPhotoDetails()
    }
}

extension ImageDetailsViewController: ImageDetailsViewProtocol {
    func update(with photo: FlickrPhotoDetails) {
        print(photo)
        print(photo.imageUrl())
    }

    func update(with error: Error) {
        //TODO: Error handling
    }


}

private extension ImageDetailsViewController {

    func fetchPhotoDetails() {
        guard let photoId = detailItem?.photoId else { return }

        presenter.getDetails(with: photoId)
    }
}

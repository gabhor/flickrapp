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
    var photoDetails: FlickrPhotoDetails?

    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var detailsLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        fetchPhotoDetails()
    }
}

extension ImageDetailsViewController: ImageDetailsViewProtocol {
    func update(with photo: FlickrPhotoDetails) {
        photoDetails = photo
        DispatchQueue.main.async {
            self.updateUI()
        }

    }

    func update(with error: Error) {
        //TODO: Error handling
    }


}

extension ImageDetailsViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {

        return imageView
    }
}

private extension ImageDetailsViewController {

    func fetchPhotoDetails() {
        guard let photoId = detailItem?.photoId, let secret = detailItem?.secret  else { return }

        presenter.getDetails(with: photoId, secret: secret)
    }

    func updateUI() {
        updatePhoto()
        updateDescription()
    }

    func updatePhoto() {
        DispatchQueue.main.async {
            if let url = self.photoDetails?.originalImageUrl() {
                self.imageView.load(url: url)
            } else if let url = self.photoDetails?.largeImageUrl() {
                self.imageView.load(url: url)
            } else {
                self.imageView.image = .none
            }
        }
    }

    func updateDescription() {
        if let photoDetails = photoDetails {
            self.detailsLabel.text = "\(photoDetails.title ?? "")\n\(photoDetails.ownerUserName ?? "") (\(photoDetails.ownerRealName ?? ""))\n\(photoDetails.taken ?? "")"
        } else {
            self.detailsLabel.text = ""
        }
    }
}

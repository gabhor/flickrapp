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
    @IBOutlet private weak var imageView: UrlImageView!
    @IBOutlet private weak var detailsLabel: UILabel!

    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        initUserInterface()
        fetchPhotoDetails()
    }
}

// MARK: - ImageDetailsViewProtocol

extension ImageDetailsViewController: ImageDetailsViewProtocol {
    func update(with photo: FlickrPhotoDetails) {
        photoDetails = photo
        DispatchQueue.main.async {
            self.updateUI()
        }
    }

    func update(with error: Error) {
        DispatchQueue.main.async {
            UIAlertController.showErrorDetails(error: error)
        }
    }
}

// MARK: - UIScrollViewDelegate

extension ImageDetailsViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}

// MARK: - Private extension

private extension ImageDetailsViewController {
    func initUserInterface() {
        title = ""
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        detailsLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        initGestureRecognizer()
        detailsLabel.font = UIFont.extraLightFont
        updateUI()
    }

    func initGestureRecognizer() {
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(doubleTap))
        doubleTapRecognizer.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTapRecognizer)
    }

    @objc func doubleTap(recognizer: UITapGestureRecognizer) {
        if scrollView.zoomScale>scrollView.minimumZoomScale {
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
        } else {
            let rect = getRectForZoom(with: recognizer.location(in: recognizer.view))
            scrollView.zoom(to: rect, animated: true)
        }
    }

    func getRectForZoom(with touch:CGPoint) -> CGRect {
        let scrollViewSize = scrollView.bounds.size
        let width = (scrollViewSize.width) / scrollView.maximumZoomScale
        let height = (scrollViewSize.height) / scrollView.maximumZoomScale
        let x = (touch.x/scrollView.zoomScale) - width/2
        let y = (touch.y/scrollView.zoomScale) - height/2
        return CGRect(x: x, y: y, width: width, height: height)
    }

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
            self.imageView.image = #imageLiteral(resourceName: "placeholderImage")
            if let thumbnailUrl = self.detailItem?.thumbnailUrl(), let photoPreview = ThumbnailCacheService.shared.getImage(for: thumbnailUrl) {
                self.imageView.image = UIImage(data: photoPreview)
            }

            if let url = self.photoDetails?.originalImageUrl() {
                self.imageView.load(urlString: url)
            } else if let url = self.photoDetails?.largeImageUrl() {
                self.imageView.load(urlString: url)
            }
        }
    }

    func updateDescription() {
        if let photoDetails = photoDetails {
            let attributedDescription = NSMutableAttributedString()
            let titleParagraphStyle = NSMutableParagraphStyle()
            titleParagraphStyle.paragraphSpacing = 15
            titleParagraphStyle.alignment = .center
            let userParagraphStyle = NSMutableParagraphStyle()
            userParagraphStyle.paragraphSpacing = 5
            userParagraphStyle.alignment = .right

            if let title = photoDetails.title {
                attributedDescription.append(NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont.lightFont, NSAttributedString.Key.paragraphStyle: titleParagraphStyle]))
            }
            if let userName = photoDetails.ownerUserName {
                attributedDescription.append(NSAttributedString(string: "\n\(userName)", attributes: [NSAttributedString.Key.font: UIFont.extraLightFont, NSAttributedString.Key.paragraphStyle: userParagraphStyle]))
            }
            if let realName = photoDetails.ownerRealName, realName.count > 0 {
                attributedDescription.append(NSAttributedString(string: " (\(realName))", attributes: [NSAttributedString.Key.font: UIFont.extraLightFont, NSAttributedString.Key.paragraphStyle: userParagraphStyle]))
            }
            if let date = photoDetails.taken {
                attributedDescription.append(NSAttributedString(string: "\n\(date)", attributes: [NSAttributedString.Key.font: UIFont.smallExtraLightFont, NSAttributedString.Key.paragraphStyle: userParagraphStyle]))
            }
            self.detailsLabel.attributedText = attributedDescription
        } else {
            self.detailsLabel.text = ""
        }
    }
}

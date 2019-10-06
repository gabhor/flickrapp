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

    func initUserInterface() {
        title = ""
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        detailsLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        initGestureRecognizer()
        detailsLabel.font = UIFont.thinFont
    }

    func initGestureRecognizer() {
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(doubleTap))
        doubleTapRecognizer.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTapRecognizer)
    }

    @objc func doubleTap(recognizer: UITapGestureRecognizer) {
        if scrollView.zoomScale<scrollView.maximumZoomScale {
            let rect = getRectForZoom(with: recognizer.location(in: recognizer.view))
            scrollView.zoom(to: rect, animated: true)
        } else {
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
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
            if let thumbnailUrl = self.detailItem?.thumbnailUrl(), let photoPreview = ThumbnailCacheService.shared.getImage(for: thumbnailUrl) {
                self.imageView.image = UIImage(data: photoPreview)
            } else {
                self.imageView.image = #imageLiteral(resourceName: "placeholderImage")
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
                attributedDescription.append(NSAttributedString(string: "\n\(userName)", attributes: [NSAttributedString.Key.font: UIFont.thinFont, NSAttributedString.Key.paragraphStyle: userParagraphStyle]))
            }

            if let realName = photoDetails.ownerRealName, realName.count > 0 {
                attributedDescription.append(NSAttributedString(string: " (\(realName))", attributes: [NSAttributedString.Key.font: UIFont.thinFont, NSAttributedString.Key.paragraphStyle: userParagraphStyle]))
            }

            if let date = photoDetails.taken {
                attributedDescription.append(NSAttributedString(string: "\n\(date)", attributes: [NSAttributedString.Key.font: UIFont.smallThinFont, NSAttributedString.Key.paragraphStyle: userParagraphStyle]))
            }


            self.detailsLabel.attributedText = attributedDescription

//                = "\(photoDetails.title ?? "")\n\(photoDetails.ownerUserName ?? "") (\(photoDetails.ownerRealName ?? ""))\n\(photoDetails.taken ?? "")"
        } else {
            self.detailsLabel.text = ""
        }
    }
}

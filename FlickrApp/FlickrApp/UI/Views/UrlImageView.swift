//
//  UrlImageView.swift
//  FlickrApp
//
//  Created by Gabor Horvath on 2019. 10. 07..
//  Copyright © 2019. Gabor Horvath. All rights reserved.
//

import UIKit

class UrlImageView: UIView {
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var activityIndicatorBackgroundView: UIView!
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    private var imageCacheEnabled: Bool = false
    private var imageUrlString: String?

    var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initCustomView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initCustomView()
    }

    func showPlaceholder() {
        imageView.image = #imageLiteral(resourceName: "placeholderImage")
    }

    func load(urlString: String, cacheEnabled: Bool = false) {
        LogService.shared.debug(" load image - url: \(urlString) cacheEnabled: \(cacheEnabled ? "YES": "NO")")
        imageUrlString = urlString
        imageCacheEnabled = cacheEnabled

        loadImage()
    }
}

// MARK: - Private extension

private extension UrlImageView {
    func initCustomView() {
        Bundle.main.loadNibNamed("UrlImageView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        activityIndicatorBackgroundView.layer.cornerRadius = 5
        activityIndicatorBackgroundView.clipsToBounds = true
    }

    func loadImage() {
        if imageCacheEnabled, let urlString = imageUrlString, let imageData = ThumbnailCacheService.shared.getImage(for: urlString), let image = UIImage(data: imageData) {
            LogService.shared.debug("cached image available")
            self.imageView.image = image
        } else {
            LogService.shared.debug("cached image not available")
            self.fetchImage()
        }
    }

    func fetchImage() {
        showActivityIndicator()
        DispatchQueue.global().async { [weak self] in
            guard let strongSelf = self else { return }

            if let urlString = strongSelf.imageUrlString, let url = URL(string: urlString), let data = try? Data(contentsOf: url) {
                strongSelf.processImageData(data)
            } else {
                strongSelf.fetchImageDidFail()
            }
        }
    }

    func fetchImageDidFail() {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }

            strongSelf.hideActivityIndicator()
            strongSelf.imageView.image = #imageLiteral(resourceName: "missing-image")
        }
    }

    func processImageData(_ data: Data) {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }

            strongSelf.hideActivityIndicator()
            if let image = UIImage(data: data) {
                if strongSelf.imageCacheEnabled, let urlString = strongSelf.imageUrlString{
                    ThumbnailCacheService.shared.cache(imageData: data, url: urlString)
                }
                strongSelf.imageView.image = image
            } else {
                strongSelf.imageView.image = #imageLiteral(resourceName: "missing-image")
            }
        }
    }

    func showActivityIndicator() {
        activityIndicatorView.isHidden = false
        activityIndicatorBackgroundView.isHidden = false
        activityIndicatorView.startAnimating()
    }

    func hideActivityIndicator() {
        activityIndicatorView.isHidden = true
        activityIndicatorBackgroundView.isHidden = true
        activityIndicatorView.stopAnimating()
    }
}

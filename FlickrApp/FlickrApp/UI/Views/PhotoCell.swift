//
//  PhotoCell.swift
//  FlickrApp
//
//  Created by Gabor Horvath on 2019. 10. 03..
//  Copyright © 2019. Gabor Horvath. All rights reserved.
//

import UIKit

class PhotoCell : UICollectionViewCell {
    @IBOutlet private weak var imageView: UIImageView!

    func displayPhoto(_ photoData: FlickrPhoto) {
        imageView.image = #imageLiteral(resourceName: "placeholderImage")

        if let url = photoData.thumbnailUrl() {
            imageView.load(url: url)
        }
    }

    func getImage() -> UIImage? {
        return imageView.image
    }
}

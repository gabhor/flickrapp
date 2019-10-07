//
//  UIFontExtension.swift
//  FlickrApp
//
//  Created by Gabor Horvath on 2019. 10. 04..
//  Copyright © 2019. Gabor Horvath. All rights reserved.
//

import UIKit

extension UIFont {

    static var homeScreenHeaderFont: UIFont {
        return UIFont(name: "Amperzand", size: 28.0) ?? UIFont.systemFont(ofSize: 28.0)
    }

    static var bigBoldFont: UIFont {
        return UIFont(name: "Exo-Bold", size: 26.0) ?? UIFont.systemFont(ofSize: 26.0)
    }

    static var lightFont: UIFont {
        return UIFont(name: "Exo-Light", size: 16.0) ?? UIFont.systemFont(ofSize: 16.0)
    }

    static var extraLightFont: UIFont {
        return UIFont(name: "Exo-ExtraLight", size: 13.0) ?? UIFont.systemFont(ofSize: 13.0)
    }

    static var smallExtraLightFont: UIFont {
        return UIFont(name: "Exo-ExtraLight", size: 10.0) ?? UIFont.systemFont(ofSize: 10.0)
    }
}

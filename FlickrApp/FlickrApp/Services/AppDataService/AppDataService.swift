//
//  AppDataService.swift
//  FlickrApp
//
//  Created by Gabor Horvath on 2019. 10. 04..
//  Copyright © 2019. Gabor Horvath. All rights reserved.
//

import Foundation

class AppDataService {
    static let shared = AppDataService()

    func getStoredSearchKeyword() -> String {
        if let keyword = UserDefaults.standard.object(forKey: Constant.App.storedKeywordKey) as? String, keyword.count > 0 {
            return keyword
        }

        return Constant.App.initialSearchText
    }

    func storeSearchKeyword(_ keyword: String) {
        UserDefaults.standard.set(keyword, forKey: Constant.App.storedKeywordKey)
        UserDefaults.standard.synchronize()
    }
}

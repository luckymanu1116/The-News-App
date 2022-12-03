//
//  Settings.swift
//  TheNews
//
//  Created by Kushagra & jaskirat on 4/2/22.
//

import Foundation

struct Settings {
    static var shared = Settings()

    static let StyleKey = "style"
    static let CategoryKey = "category"

    static let StyleDefault: NewsViewModel.Style = .cnn
    static let CategoryDefault: NewsCategory = .general

    var category: NewsCategory = UserDefaultsConfig.savedCategory {
        didSet {
            UserDefaultsConfig.savedCategory = category
        }
    }

    var style: NewsViewModel.Style = UserDefaultsConfig.savedStyle {
        didSet {
            UserDefaultsConfig.savedStyle = style
        }
    }
}

struct UserDefaultsConfig {
    @UserDefault(Settings.CategoryKey, defaultValue: Settings.CategoryDefault)
    static var savedCategory: NewsCategory

    @UserDefault(Settings.StyleKey, defaultValue: Settings.StyleDefault)
    static var savedStyle: NewsViewModel.Style
}

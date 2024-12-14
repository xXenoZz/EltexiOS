//
//  DownloadOptions.swift
//  Images
//
//  Created by KozlovKonstantin on 29.11.2024.
//

import Foundation

enum DownloadOptions {
    enum From {
        case disk
        case memory
    }
    case circle
    case cached(From)
    case resize(CGSize)
}

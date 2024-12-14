//
//  CachedImageInfo.swift
//  Images
//
//  Created by KozlovKonstantin on 29.11.2024.
//

import Foundation

struct CachedImageInfo: Hashable {
    let fileName: String
    let url: URL
    var isCircled: Bool
    var isResized: Bool
    
    init(url: URL, withOptions options: [DownloadOptions]) {
        let fileName = url.lastPathComponent
        var circled: Bool = false
        var resized: Bool = false
        
        for option in options {
            switch option {
            case .cached:
                break
            case .circle:
                circled = true
            case .resize:
                resized = true
            }
        }
        
        self.fileName = fileName
        self.url = url
        self.isCircled = circled
        self.isResized = resized
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(url.absoluteString)
        hasher.combine(isCircled)
        hasher.combine(isResized)
    }

    func getImageFileName() -> NSString {
        var imageFileName = fileName
        if isCircled {
            imageFileName += "_circled"
        }
        if isResized {
            imageFileName += "_resized"
        }
        return imageFileName as NSString
    }
}

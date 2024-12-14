//
//  Downloadable.swift
//  Images
//
//  Created by KozlovKonstantin on 29.11.2024.
//

import Foundation
import UIKit

protocol Downloadable {
    func loadImage(from url: URL, withOptions: [DownloadOptions])
}

extension Downloadable where Self: UIImageView {
    func loadImage(from url: URL, withOptions options: [DownloadOptions]) {
        let imageCachedInfo = CachedImageInfo(url: url, withOptions: options)
        
        ImageLoader.shared.fetchImage(with: imageCachedInfo, applying: options) { image in
            guard let image else {
                return
            }
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}

class DownloadableImageView: UIImageView, Downloadable {}


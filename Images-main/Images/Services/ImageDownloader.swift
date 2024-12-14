//
//  ImageDownloader.swift
//  Images
//
//  Created by KozlovKonstantin on 29.11.2024.
//

import Foundation
import UIKit

protocol ImageDownloaderProtocol {
    func download( from url: URL,
                        completion: @escaping (UIImage?) -> Void)
}

class ImageDownloader {}

extension ImageDownloader: ImageDownloaderProtocol {
    func download(from url: URL,
                       completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
}

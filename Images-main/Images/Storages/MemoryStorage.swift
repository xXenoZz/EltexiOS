//
//  MemoryStorage.swift
//  Images
//
//  Created by KozlovKonstantin on 29.11.2024.
//

import Foundation
import UIKit

class MemoryStorage {
    let cache = NSCache<NSString, UIImage>()
    static let shared = MemoryStorage()
    
    func saveImage(_ image: UIImage, forKey key: NSString) {
        DispatchQueue.main.async { [weak self] in
            self?.cache.setObject(image, forKey: key)
        }
    }

    func getImage(forKey key: NSString) -> UIImage? {
        cache.object(forKey: key)
    }
}

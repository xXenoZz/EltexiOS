//
//  ImageOptionsHandler.swift
//  Images
//
//  Created by KozlovKonstantin on 29.11.2024.
//

import Foundation
import UIKit

final class ImageOptionsHandler {
    private var imageDetails: CachedImageInfo
    private var options: [DownloadOptions]
    let imageOptionsManagerQueue = DispatchQueue(label: "imageOptionsManagerQueue")
    
    
    init(imageDetails: CachedImageInfo, options: [DownloadOptions]) {
        self.imageDetails = imageDetails
        self.options = options
    }
    
    func processImage(image: UIImage, cached: Bool, completion: @escaping (UIImage) -> Void) {
        var transformedImage = image
        
        var isAlreadyCached = false
        var isAlreadyCircled = imageDetails.isCircled
        var isAlreadyResized = imageDetails.isResized
        
        let dispatchGroup = DispatchGroup()
        
        for option in options {
            imageOptionsManagerQueue.async(group: dispatchGroup) {
                switch option {
                case .cached(let source) where !cached && !isAlreadyCached:
                    switch source {
                    case .memory:
                        MemoryStorage.shared.saveImage(transformedImage,
                                                      forKey: String(self.imageDetails.hashValue) as NSString)
                    case .disk:
                        DiskStorage.shared.saveImage(transformedImage,
                                                               forKey: self.imageDetails.getImageFileName())
                    }
                    isAlreadyCached = true
                case .circle where  !(cached && isAlreadyCircled):
                    transformedImage = self.circleCrop(image: transformedImage)
                    isAlreadyCircled = true
                    
                case .resize(let size) where !(isAlreadyResized && cached):
                    transformedImage = self.resizeImage(image: transformedImage, targetSize: size)
                    isAlreadyResized = true
                default:
                    break
                }
            }
        }
        dispatchGroup.notify(queue: DispatchQueue.main) {
            completion(transformedImage)
        }
    }
    
    func findCacheSource() -> DownloadOptions.From? {
        for option in options {
            if case let .cached(from) = option {
                return from
            }
        }
        return nil
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }
    
    func circleCrop(image: UIImage) -> UIImage {
        let minEdge = min(image.size.width, image.size.height)
        let targetSize = CGSize(width: minEdge, height: minEdge)
        
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { context in
            let rect = CGRect(origin: .zero, size: targetSize)
            context.cgContext.addEllipse(in: rect)
            context.cgContext.clip()
            image.draw(in: rect)
        }
    }
}

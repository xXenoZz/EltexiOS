//
//  ImageLoader.swift
//  Images
//
//  Created by KozlovKonstantin on 29.11.2024.
//
import Foundation
import UIKit

class ImageLoader {
    private var activeRequests = [NSString: [((UIImage?) -> Void)]]()
    static let shared = ImageLoader(downloader: ImageDownloader())

    private let downloader: ImageDownloaderProtocol

    init(downloader: ImageDownloaderProtocol) {
        self.downloader = downloader
    }

    func fetchImage(with info: CachedImageInfo,
                    applying options: [DownloadOptions],
                    completion: @escaping (UIImage?) -> Void) {

        let cacheKey = info.fileName as NSString
        let optionsHandler = ImageOptionsHandler(imageDetails: info, options: options)

        // Проверка кэша (память или диск)
        if let cachingSource = optionsHandler.findCacheSource() {
            switch cachingSource {
            case .memory:
                if let memoryCachedImage = MemoryStorage.shared.getImage(forKey: cacheKey) {
                    optionsHandler.processImage(image: memoryCachedImage, cached: true) { processedImage in
                        completion(processedImage)
                    }
                    return
                }

            case .disk:
                DiskStorage.shared.getImage(forKey: cacheKey) { diskImage in
                    if let diskImage {
                        optionsHandler.processImage(image: diskImage, cached: true) { processedImage in
                            completion(processedImage)
                        }
                        return
                    }
                }
            }
        }

        // Проверка активных запросов
        if activeRequests[cacheKey] != nil {
            activeRequests[cacheKey]?.append(completion)
            return
        } else {
            activeRequests[cacheKey] = [completion]
        }

        // Загрузка изображения
        let imageUrl = info.url
        downloader.download(from: imageUrl) { [weak self] loadedImage in
            guard let self, let loadedImage else {
                return
            }

            // Асинхронная обработка изображения
            DispatchQueue.global(qos: .userInitiated).async {
                optionsHandler.processImage(image: loadedImage, cached: false) { finalImage in
                    DispatchQueue.main.async {
                        self.activeRequests[cacheKey]?.forEach { callback in
                            callback(finalImage)
                        }
                        self.activeRequests[cacheKey] = nil
                    }
                }
            }
        }
    }
}


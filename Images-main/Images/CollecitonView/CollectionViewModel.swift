//
//  CollectionViewModel.swift
//  Images
//
//  Created by KozlovKonstantin on 29.11.2024.
//

import Foundation

class CollectionViewModel {
    private let imagesURL = ["https://demo-source.imgix.net/puppy.jpg", "https://demo-source.imgix.net/canyon.jpg", "https://demo-source.imgix.net/mountains.jpg", "https://demo-source.imgix.net/plant.jpg", "https://demo-source.imgix.net/scooter.jpg", "https://demo-source.imgix.net/sneakers.jpg", "https://demo-source.imgix.net/house.jpg",
        "https://demo-source.imgix.net/snowboard.jpg"
    ]
    
    private let imagesCount: Int
    lazy var randomImages: [ImageViewModel] = []
    
    init(imagesCount: Int) {
        self.imagesCount = imagesCount
        generateRandomImageArray()
    }
    
    func generateRandomImageArray() {
        guard imagesCount > 0 else {
            return
        }
        
        for i in 0..<imagesCount {
            if let randomElement = imagesURL.randomElement(), let imageURL = URL(string: randomElement) {
                randomImages.append(.init(fileName: "image\(i)", imageURL: imageURL))
            }
        }
    }
}

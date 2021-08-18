//
//  TrandResponseManager.swift
//  GiphyView
//
//  Created by BMF on 11.08.21.
//  Copyright © 2021 Zero. All rights reserved.
//


import Foundation
import UIKit

class TrandResponseManager: ImageDataManager {
    
    private var trandResponse: TrandResponse?
    private let networkDataFetcher = NetworkDataFetcher()
    private let apiKey = "Y3ZdGlCifvM1LYlS92rI8V7PIHisF2Cq"
    private let quantityOfImages = 20
    
    func update(handler: @escaping (Any) -> Void) {
        networkDataFetcher.loadImagesInfo(quantityOfImages: quantityOfImages) { trandResponse in
            self.trandResponse = trandResponse
            handler(trandResponse)
        }
    }
}

extension TrandResponseManager {
    
    func quantityOfModels() -> Int {
        return trandResponse?.data.count ?? 0
    }
    
    func loadImage(index: Int, completion: @escaping (UIImage?) -> Void) {
        networkDataFetcher.loadImageDataTask(stringUrl: trandResponse!.data[index].images.original.url) { image in
            completion(image)
        }
    }
}

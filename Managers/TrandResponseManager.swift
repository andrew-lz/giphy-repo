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
    
    private var trandResponse: GiphyAPIResponse?
    private let networkDataFetcher = NetworkDataFetcher()
    private let apiKey = "Y3ZdGlCifvM1LYlS92rI8V7PIHisF2Cq"
    private let quantityOfImagesOnPage = 20
    
    func loadPage(pageNumber: Int, handler: @escaping (GiphyAPIResponse) -> Void) {
        networkDataFetcher.loadImagesPage(pageNumber: pageNumber, quantityOfImages: quantityOfImagesOnPage) { trandResponse in
            handler(trandResponse)
        }
    }
    
    func initModelWithFirstPage(handler: @escaping (GiphyAPIResponse) -> Void) {
        loadPage(pageNumber: 0) { trandResponse in
            self.trandResponse = trandResponse
            handler(trandResponse)
        }
    }
    
    func updateModelWithPage(pageNumber: Int, handler: @escaping (GiphyAPIResponse) -> Void) {
        loadPage(pageNumber: pageNumber) { trandResponse in
            self.trandResponse?.data.append(contentsOf: trandResponse.data)
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

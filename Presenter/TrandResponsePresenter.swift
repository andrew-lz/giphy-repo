//
//  TrandResponsePresenter.swift
//  GiphyView
//
//  Created by BMF on 11.08.21.
//  Copyright © 2021 Zero. All rights reserved.
//

import Foundation
import UIKit

class TrandResponsePresenter: ImageDataPresenter {
    
    private let view: ImageView
    private var trandResponse: GiphyAPIResponse?
    private let cache = NSCache<NSNumber, UIImage>()
    private let networkDataFetcher = NetworkDataFetcher()
    private let apiKey = "Y3ZdGlCifvM1LYlS92rI8V7PIHisF2Cq"
    private let quantityOfImagesOnPage = 20
    
    required init(view: ImageView) {
        self.view = view
    }
    
    func loadPage(pageNumber: Int, handler: @escaping (GiphyAPIResponse) -> Void) {
        networkDataFetcher.loadImagesPage(pageNumber: pageNumber, quantityOfImages: quantityOfImagesOnPage) { trandResponse in
            handler(trandResponse)
            DispatchQueue.main.async {
                self.view.reloadData()
            }
        }
    }
    
    func initModelWithFirstPage(handler: @escaping (GiphyAPIResponse) -> Void) {
        loadPage(pageNumber: 0) { trandResponse in
            self.trandResponse = trandResponse
            handler(trandResponse)
        }
    }
    
    func updateModelWithPage(index: Int, handler: @escaping (GiphyAPIResponse, Int) -> Void) {
        
        if (index == (quantityOfImages() - 1)) {
            let pageNumber = quantityOfImages() / 20
            loadPage(pageNumber: pageNumber) { trandResponse in
                self.trandResponse?.data.append(contentsOf: trandResponse.data)
                handler(trandResponse, pageNumber)
            }
        }
    }
    
    func quantityOfImages() -> Int {
        return trandResponse?.data.count ?? 0
    }
    
    func setImage(index: Int, completion: @escaping (UIImage?) -> Void) {
        let itemNumber = NSNumber(value: index)
        if let cachedImage = cache.object(forKey: itemNumber) {
            completion(cachedImage)
        } else {
            networkDataFetcher.loadImageDataTask(stringUrl: trandResponse!.data[index].images.original.url) { image in
                completion(image)
                self.cache.setObject(image!, forKey: itemNumber)
            }
        }
    }
}

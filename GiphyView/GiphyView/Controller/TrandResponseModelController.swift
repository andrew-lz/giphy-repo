//
//  TrandResponseModelController.swift
//  GiphyView
//
//  Created by BMF on 11.08.21.
//  Copyright © 2021 Zero. All rights reserved.
//

import Foundation
import UIKit

class TrandResponseModelController {
    private var trandResponse: TrandResponse?
    private let networkDataFetcher = NetworkDataFetcher()
    private let apiKey = "Y3ZdGlCifvM1LYlS92rI8V7PIHisF2Cq"
    
    func update(quantityOfImages: Int, then handler: @escaping (TrandResponse) -> Void) {
        let randomUUID = UUID().uuidString
        let url: String = "https://api.giphy.com/v1/gifs/trending?api_key=\(apiKey)&limit=\(quantityOfImages)&rating=g&random_id=\(randomUUID)"
        networkDataFetcher.fetchImages(urlString: url) { (trandResponse) in
            guard let trandResponse = trandResponse else { return }
            self.trandResponse = trandResponse
            handler(trandResponse)
        }
    }
}

extension TrandResponseModelController {
    
    func quantityOfModels() -> Int {
        return trandResponse?.data.count ?? 0
    }
    
    func loadImageDataTask(index: Int, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: trandResponse!.data[index].images.original.url) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            DispatchQueue.main.async {
                if error != nil {
                    print("Some error")
                    completion(nil)
                    return
                }
                guard let data = data else { return }
                let image = UIImage.gifImageWithData(data)
                completion(image)
            }
        }.resume()
    }
}

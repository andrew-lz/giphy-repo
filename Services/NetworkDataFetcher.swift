//
//  NetworkDataFetcher.swift
//  GiphyView
//
//  Created by BMF on 23.07.21.
//  Copyright © 2021 Zero. All rights reserved.
//


import Foundation
import UIKit

class NetworkDataFetcher {
    private let networkService = NetworkService()
    func fetchImages(urlString: String, response: @escaping (GiphyAPIResponse?) -> Void) {
        networkService.request(urlString: urlString) { (result) in
            switch result {
            case .success(let data):
                do {
                    let images = try JSONDecoder().decode(GiphyAPIResponse.self, from: data)
                    response(images)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                }
            case .failure(let error):
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
        }
    }
    
    func loadImagesPage(pageNumber: Int, quantityOfImages: Int, then handler: @escaping (GiphyAPIResponse) -> Void) {
        let networkDataFetcher = NetworkDataFetcher()
        let apiKey = "Y3ZdGlCifvM1LYlS92rI8V7PIHisF2Cq"
        let randomUUID = UUID().uuidString
        let url: String = "https://api.giphy.com/v1/gifs/trending?api_key=\(apiKey)&offset=\(pageNumber * quantityOfImages)&limit=\(quantityOfImages)&rating=g&random_id=\(randomUUID)"
        networkDataFetcher.fetchImages(urlString: url) { trandResponse in
            guard let trandResponse = trandResponse else { return }
            handler(trandResponse)
        }
    }
    
    func loadImageDataTask(stringUrl: String, completion: @escaping (UIImage?)-> Void) {
        guard let url = URL(string: stringUrl) else { return }
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

private class NetworkService {
    func request(urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("Some error")
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                completion(.success(data))
            }
        }.resume()
    }
}

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
    
    private func fetchImages(urlString: String, response: @escaping (GiphyAPIResponse?) -> Void) {
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
    
    private func trandUrl(pageNumber: Int) -> String {
        let api_key = "Y3ZdGlCifvM1LYlS92rI8V7PIHisF2Cq"
        let quantityOfImagesOnPage = 20
        let randomUUID = UUID().uuidString
        let queryParams: [String: String] = [
            "api_key": String(api_key),
            "offset": String(pageNumber * quantityOfImagesOnPage),
            "limit": String(quantityOfImagesOnPage),
            "rating": "g",
            "random_id": String(randomUUID)
        ]
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.giphy.com"
        urlComponents.path = "/v1/gifs/trending"
        urlComponents.setQueryItems(with: queryParams)
        return urlComponents.url!.absoluteString
    }
    
    func loadImagesPage(pageNumber: Int, then handler: @escaping ([Info]) -> Void) {
        let url: String = trandUrl(pageNumber: pageNumber)
        fetchImages(urlString: url) { trandResponse in
            guard let trandResponse = trandResponse else { return }
            handler(trandResponse.data)
        }
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

extension URLComponents {
    
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}

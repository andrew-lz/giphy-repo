//
//  NetworkDataFetcher.swift
//  GiphyView
//
//  Created by BMF on 23.07.21.
//  Copyright © 2021 Zero. All rights reserved.
//

import Foundation

class NetworkDataFetcher {
    private let networkService = NetworkService()
    func fetchImages(urlString: String, response: @escaping (TrandResponse?) -> Void) {
        networkService.request(urlString: urlString) { (result) in
            switch result {
            case .success(let data):
                do {
                    let images = try JSONDecoder().decode(TrandResponse.self, from: data)
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

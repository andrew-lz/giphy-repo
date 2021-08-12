//
//  NetworkService.swift
//  GiphyView
//
//  Created by BMF on 12.08.21.
//  Copyright © 2021 Zero. All rights reserved.
//

import Foundation

class NetworkService {
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

//
//  TrandResponse.swift
//  GiphyView
//
//  Created by BMF on 16.07.21.
//  Copyright © 2021 Zero. All rights reserved.
//

import Foundation

struct GiphyAPIResponse: Decodable {
    let data: [Info]
}

struct Info: Decodable {
    let images: Image
}

struct Image: Decodable {
    let original: Original
}

struct Original: Decodable {
    let url: String
}

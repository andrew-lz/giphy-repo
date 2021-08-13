//
//  TrandResponse.swift
//  GiphyView
//
//  Created by BMF on 16.07.21.
//  Copyright © 2021 Zero. All rights reserved.
//

import Foundation

struct TrandResponse: Decodable {
    var data: [Info]
}

struct Info: Decodable {
    var images: Image
}

struct Image: Decodable {
    var original: Original
}

struct Original: Decodable {
    var url: String
}

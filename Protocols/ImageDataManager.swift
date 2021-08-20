//
//  ImageDataManager.swift
//  GiphyView
//
//  Created by BMF on 17.08.21.
//  Copyright © 2021 Zero. All rights reserved.
//

import Foundation
import UIKit

protocol ImageDataManager {
    
    func initModelWithFirstPage(handler: @escaping (GiphyAPIResponse) -> Void)
    func updateModelWithPage(pageNumber: Int, handler: @escaping (GiphyAPIResponse) -> Void)
    func loadPage(pageNumber: Int, handler: @escaping (GiphyAPIResponse) -> Void)
    func quantityOfModels() -> Int
    func loadImage(index: Int, completion: @escaping (UIImage?) -> Void)
}

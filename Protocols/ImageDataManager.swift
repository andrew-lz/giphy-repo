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
    
    func update(handler: @escaping (Any) -> Void)
    func quantityOfModels() -> Int
    func loadImage(index: Int, completion: @escaping (UIImage?) -> Void)
}

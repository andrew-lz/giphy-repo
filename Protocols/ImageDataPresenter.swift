//
//  ImageDataPresenter.swift
//  GiphyView
//
//  Created by BMF on 17.08.21.
//  Copyright © 2021 Zero. All rights reserved.
//

import Foundation
import UIKit

protocol ImageDataPresenter {
    init(view: ImageView)
    
    func initModelWithFirstPage(handler: @escaping (GiphyAPIResponse) -> Void)
    func updateModelWithPage(index: Int, handler: @escaping (GiphyAPIResponse, Int) -> Void)
    func loadPage(pageNumber: Int, handler: @escaping (GiphyAPIResponse) -> Void)
    func quantityOfImages() -> Int
    func setImage(index: Int, completion: @escaping (UIImage?) -> Void)
}

//
//  ImageView.swift
//  GiphyView
//
//  Created by BMF on 20.08.21.
//  Copyright © 2021 Zero. All rights reserved.
//

import Foundation
import UIKit

protocol ImageView: AnyObject {
    func reloadData()
    func configure(viewModels: [ViewModel])
    func loadingAnimation()
    func stopLoadingAnimation()
}

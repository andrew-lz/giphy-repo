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

    func loadPage(_ notification: Notification, handler: @escaping ([Any]) -> Void)
    func didStart()
}

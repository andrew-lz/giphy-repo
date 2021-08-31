//
//  TrandResponsePresenter.swift
//  GiphyView
//
//  Created by BMF on 11.08.21.
//  Copyright © 2021 Zero. All rights reserved.
//

import Foundation
import UIKit

class TrandResponsePresenter: ImageDataPresenter {
    
    private let view: ImageView
    private let networkDataFetcher = NetworkDataFetcher()
    private var pageNumber = 0
    
    required init(view: ImageView) {
        self.view = view
        NotificationCenter.default.addObserver(forName: NSNotification.Name(Notifications.didScrollToTheEnd.rawValue), object: nil, queue: OperationQueue.current) { notification in
            print("Loading page \(self.pageNumber)")
            self.loadPage { _ in
                print("Loaded page \(self.pageNumber - 1)")
            }
        }
    }
    
    deinit {
        NotificationCenter.default
            .removeObserver(self, name: NSNotification.Name(Notifications.didScrollToTheEnd.rawValue), object: nil)
    }
    
    @objc func loadPage(handler: @escaping ([Any]) -> Void) {
        var viewModels = [ViewModel]()
        self.view.loadingAnimation()
        networkDataFetcher.loadImagesPage(pageNumber: pageNumber) { imagesInfo in
            imagesInfo.forEach { imagesInfo in
                viewModels.append(ViewModel(image: UIImage.gifImageWithURL(imagesInfo.images.original.url)!))
            }
            handler(imagesInfo)
            self.view.configure(viewModels: viewModels)
            self.view.reloadData()
            self.view.stopLoadingAnimation()
        }
        pageNumber += 1
    }
    
    func didStart() {
        loadPage(handler: { imagesInfo in
            print("Loaded page 0")
        })
    }
}

enum Notifications: String {
    case didScrollToTheEnd
}

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
    
    required init(view: ImageView) {
        self.view = view
        NotificationCenter.default.addObserver(forName: NSNotification.Name(Notifications.didScrollToTheEnd.rawValue), object: nil, queue: OperationQueue.current) { notification in
            print("Loading page \(notification.object ?? 0)")
            self.loadPage(notification) { _ in
                print("Loaded page \(notification.object ?? 0)")
            }
        }
    }
    
    deinit {
        NotificationCenter.default
            .removeObserver(self, name: NSNotification.Name(Notifications.didScrollToTheEnd.rawValue), object: nil)
    }
    
    @objc func loadPage(_ notification: Notification, handler: @escaping ([Any]) -> Void) {
        var viewModels = [ViewModel]()
        self.view.loadingAnimation()
        networkDataFetcher.loadImagesPage(pageNumber: (notification.object as? Int) ?? 0) { imagesInfo in
            imagesInfo.forEach { imagesInfo in
                viewModels.append(ViewModel(image: UIImage.gifImageWithURL(imagesInfo.images.original.url)!))
            }
            handler(imagesInfo)
            self.view.configure(viewModels: viewModels)
            self.view.reloadData()
            self.view.stopLoadingAnimation()
        }
    }
    
    func didStart() {
        loadPage(Notification(name: Notification.Name(rawValue: Notifications.didScrollToTheEnd.rawValue)), handler: { imagesInfo in
            print("Loaded page 0")
        })
    }
}

enum Notifications: String {
    case didScrollToTheEnd
}

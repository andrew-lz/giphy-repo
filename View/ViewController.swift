//
//  ViewController.swift
//  GiphyView
//
//  Created by BMF on 15.07.21.
//  Copyright © 2021 Zero. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, ImageView {
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let loadingIndicator = UIActivityIndicatorView()
        loadingIndicator.color = .cyan
        loadingIndicator.style = .large
        
        return loadingIndicator
    }()
    private var viewModels = [ViewModel]()
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    func loadingAnimation() {
        loadingIndicator.frame =  view.bounds
        loadingIndicator.center = view.center
        view.mask = UIView(frame: self.view.frame)
        view.mask?.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.addSubview(loadingIndicator)
        loadingIndicator.startAnimating()
    }
    
    func stopLoadingAnimation() {
        loadingIndicator.stopAnimating()
        loadingIndicator.removeFromSuperview()
        view.mask = nil
    }
    
    func configure(viewModels: [ViewModel]) {
        self.viewModels.append(contentsOf: viewModels)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
    }
}

// MARK: - UICollectionViewDataSource
extension ViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
        cell.configure(with: viewModels[indexPath.item].image)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension ViewController {
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.item == (viewModels.count - 1)) {
            NotificationCenter.default.post(Notification(name: NSNotification.Name(rawValue: Notifications.didScrollToTheEnd.rawValue), object: nil))
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("User tapped item \(indexPath.item + 1)")
    }
}

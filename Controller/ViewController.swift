//
//  ViewController.swift
//  GiphyView
//
//  Created by BMF on 15.07.21.
//  Copyright © 2021 Zero. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {
    
    private let utilityQueue = DispatchQueue.global(qos: .utility)
    private let cache = NSCache<NSNumber, UIImage>()
    private let trandResponseController: TrandResponseModelController = TrandResponseModelController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        trandResponseController.update(quantityOfImages: 9, then: { _ in
            self.collectionView!.reloadData()
        })
    }
}

// MARK: - UICollectionViewDataSource
extension ViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trandResponseController.quantityOfModels()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension ViewController {
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? CustomCollectionViewCell else { return }
        if cell.imageView.image == nil {
            cell.loadingIndicator.startAnimating()
        }
        let itemNumber = NSNumber(value: indexPath.item)
        if let cachedImage = self.cache.object(forKey: itemNumber) {
            print("Using a cached image for item: \(itemNumber)")
            cell.imageView.image = cachedImage
        } else {
            trandResponseController.loadImageDataTask(index: indexPath.item, completion: { [weak self] (image) in
                guard let self = self, let image = image else { return }
                cell.loadingIndicator.stopAnimating()
                cell.imageView.image = image
                self.cache.setObject(image, forKey: itemNumber)
            })
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("User tapped item \(indexPath.item + 1)")
    }
}

//
//  ViewController.swift
//  GiphyView
//
//  Created by BMF on 15.07.21.
//  Copyright © 2021 Zero. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {
    
    private let cache = NSCache<NSNumber, UIImage>()
    private let imageDataManager: ImageDataManager
    
    init(dataManager: ImageDataManager) {
        self.imageDataManager = dataManager
        super.init(collectionViewLayout: CollectionViewLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        imageDataManager.initModelWithFirstPage { _ in
            self.collectionView!.reloadData()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension ViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageDataManager.quantityOfModels()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
        let itemNumber = NSNumber(value: indexPath.item)
        if let cachedImage = self.cache.object(forKey: itemNumber) {
            print("Using a cached image for item: \(itemNumber)")
            cell.configure(with: cachedImage)
        } else {
            imageDataManager.loadImage(index: indexPath.item, completion: { [weak self] (image) in
                guard let self = self, let image = image else { return }
                cell.configure(with: image)
                self.cache.setObject(image, forKey: itemNumber)
            })
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension ViewController {
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.item == imageDataManager.quantityOfModels() - 1) {
            let pageNumber: Int = imageDataManager.quantityOfModels() / 20 
            imageDataManager.updateModelWithPage(pageNumber: pageNumber, handler: { _ in
                self.collectionView!.reloadData()
            })
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("User tapped item \(indexPath.item + 1)")
    }
}

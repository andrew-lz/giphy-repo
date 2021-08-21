//
//  ViewController.swift
//  GiphyView
//
//  Created by BMF on 15.07.21.
//  Copyright © 2021 Zero. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, ImageView {
    
    var imageDataPresenter: ImageDataPresenter!

    func reloadData() {
        collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        imageDataPresenter.initModelWithFirstPage { _ in
            print("Loading page 1")
        }
    }
}

// MARK: - UICollectionViewDataSource
extension ViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageDataPresenter.quantityOfImages()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
        imageDataPresenter.setImage(index: indexPath.item, completion: { image in
            guard let image = image else { return }
            cell.configure(with: image)
        })
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension ViewController {
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        imageDataPresenter.updateModelWithPage(index: indexPath.item) { (_, pageNumber) in
            print("Loading page \(pageNumber + 1)")
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("User tapped item \(indexPath.item + 1)")
    }
}

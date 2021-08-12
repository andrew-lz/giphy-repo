//
//  CustomCollectionViewCell.swift
//  GiphyView
//
//  Created by BMF on 1.08.21.
//  Copyright © 2021 Zero. All rights reserved.
//

import Foundation
import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    static var identifier: String = "CustomCollectionViewCell"
    let loadingIndicator: UIActivityIndicatorView = {
        let loadingIndicator = UIActivityIndicatorView()
        loadingIndicator.color = .black
        return loadingIndicator
    }()
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadingIndicator.center = self.contentView.center
        self.contentView.addSubview(loadingIndicator)
        self.contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor
                .constraint(equalTo: self.contentView.topAnchor),
            imageView.leftAnchor
                .constraint(equalTo: self.contentView.leftAnchor),
            imageView.rightAnchor
                .constraint(equalTo: self.contentView.rightAnchor),
            imageView.bottomAnchor
                .constraint(equalTo: self.contentView.bottomAnchor)
        ])
        self.backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
}

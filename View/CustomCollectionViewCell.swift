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
    
    static let identifier: String = "CustomCollectionViewCell"
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor
                .constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor
                .constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor
                .constraint(equalTo: contentView.rightAnchor),
            imageView.bottomAnchor
                .constraint(equalTo: contentView.bottomAnchor)
        ])
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with image: UIImage) {
        imageView.image = image
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}

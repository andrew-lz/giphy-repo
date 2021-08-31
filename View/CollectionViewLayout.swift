//
//  CollectionViewLayout.swift
//  GiphyView
//
//  Created by BMF on 5.08.21.
//  Copyright © 2021 Zero. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepare() {
        super.prepare()
        if UIDevice.current.orientation.isPortrait {
            let widthHeightConstant = ((UIScreen.main.bounds.width - 2))
            self.itemSize = CGSize(width: widthHeightConstant,
                                   height: widthHeightConstant)
            minimumInteritemSpacing = 1
            minimumLineSpacing = 1
            scrollDirection = .vertical
            invalidateLayout()
        } else if UIDevice.current.orientation.isLandscape {
            let widthConstant = UIScreen.main.bounds.width / 3 - 1
            let heightConstant = UIScreen.main.bounds.height / 2 - 2
            itemSize = CGSize(width: widthConstant,
                                   height: heightConstant)
            minimumInteritemSpacing = 1
            minimumLineSpacing = 1
            scrollDirection = .vertical
            invalidateLayout()
        }
    }
}

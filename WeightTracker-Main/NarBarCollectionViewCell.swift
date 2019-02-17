//
//  NarBarCollectionViewCell.swift
//  WeightTracker-Main
//
//  Created by Phan Nhat Dang on 2/17/19.
//  Copyright © 2019 Phan Nhat Dang. All rights reserved.
//

import UIKit

class NarBarCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView! {
        didSet {
            image.tintColor = #colorLiteral(red: 0.7289724051, green: 0.6552841139, blue: 1, alpha: 1)
        }
    }
    override var isHighlighted: Bool {
        didSet {
            image.tintColor = !isHighlighted ? #colorLiteral(red: 0.7289724051, green: 0.6552841139, blue: 1, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

        }
    }
    
    override var isSelected: Bool {
        didSet {
            image.tintColor = !isSelected ? #colorLiteral(red: 0.7289724051, green: 0.6552841139, blue: 1, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

        }
    }
}

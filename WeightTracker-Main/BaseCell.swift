//
//  BaseCell.swift
//  WeightTracker-Main
//
//  Created by Phan Nhat Dang on 2/17/19.
//  Copyright © 2019 Phan Nhat Dang. All rights reserved.
//

import Foundation

class BaseCell: UICollectionViewCell
{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    func setUpView()
    {
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init (coder:) has been implemented")
    }
}

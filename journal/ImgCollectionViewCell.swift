//
//  ImgCollectionViewCell.swift
//  journal
//
//  Created by wuyangbing on 14/11/12.
//  Copyright (c) 2014年 wuyangbing. All rights reserved.
//

import UIKit

class ImgCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.greenColor()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

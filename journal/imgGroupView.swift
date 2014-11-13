//
//  imgGroupView.swift
//  journal
//
//  Created by wuyangbing on 14/11/13.
//  Copyright (c) 2014年 wuyangbing. All rights reserved.
//

import UIKit

class imgGroupView: UICollectionReusableView {
    var title:UILabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.backgroundColor = UIColor.clearColor()
        self.alpha = 1.0
        self.hidden = false;
        title.frame = CGRect(x: 24.0/2.0, y: 0.0, width: frame.size.width - 24.0, height: frame.size.height)
        title.font = UIFont.systemFontOfSize(13)
        title.textAlignment = .Left
        title.textColor = UIColor(white: 0.2, alpha: 1.0)
        title.backgroundColor = UIColor.clearColor()
        self.addSubview(title)
//        var panGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "didtap")
//        self.addGestureRecognizer(panGesture)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}

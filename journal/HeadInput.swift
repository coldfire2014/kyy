//
//  HeadInput.swift
//  journal
//
//  Created by wuyangbing on 14/11/10.
//  Copyright (c) 2014年 wuyangbing. All rights reserved.
//

import UIKit

class HeadInput: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var headAdd:PicView = PicView(frame: CGRect(x: 0, y: 0, width: 120.0/2.0, height: 120.0/2.0))
    override init(frame: CGRect) {
        super.init(frame: frame)
        userInteractionEnabled = true
        self.addSubview(headAdd)
        var panGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "taphead")
        headAdd.addGestureRecognizer(panGesture)

    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func taphead(){
        NSNotificationCenter.defaultCenter().postNotificationName(MSG_EDIT_HEAD, object: nil)
    }
}

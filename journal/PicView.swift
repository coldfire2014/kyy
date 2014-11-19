//
//  PicView.swift
//  journal
//
//  Created by wuyangbing on 14/11/10.
//  Copyright (c) 2014年 wuyangbing. All rights reserved.
//

import UIKit

class PicView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.userInteractionEnabled = true
        self.backgroundColor = UIColor.clearColor()
        var bg = UIView(frame: self.bounds)
        bg.alpha = 0.45
        self.addSubview(bg)
        bg.backgroundColor = UIColor(red: 166.0/255.0, green: 196.0/255.0, blue: 207.0/255.0, alpha: 1)
        var add1:UIView = UIView(frame: CGRect(x: 0, y: 0, width: 1.5, height: 24))
        add1.backgroundColor = UIColor(red: 225.0/255.0, green: 227.0/255.0, blue: 231.0/255.0, alpha: 1)
        add1.center = CGPoint(x: 30, y: 30)
        bg.addSubview(add1)
        var add2:UIView = UIView(frame: CGRect(x: 0, y: 0, width: 48.0/2.0, height: 1.5))
        add2.backgroundColor = UIColor(red: 225.0/255.0, green: 227.0/255.0, blue: 231.0/255.0, alpha: 1)
        add2.center = CGPoint(x: 30, y: 30)
        bg.addSubview(add2)
        
        var imgLayer = UIView(frame: CGRect(x: 0, y: 0, width: 120.0/2.0, height: 120.0/2.0))
        imgLayer.backgroundColor = UIColor.clearColor()
        imgLayer.clipsToBounds = true
        self.addSubview(imgLayer)
        ///////////////////////////////
//        var test:myImageView = myImageView(frame: CGRect(x: 0, y: 0, width: 120.0/2.0, height: 360.0/2.0), name: "bk2", scale: 2.0)
//        test.center = CGPoint(x: 30, y: 30)
//        imgLayer.addSubview(test)
        ////////////////////////////////
        var removeBtn = UIView(frame: CGRect(x: 0, y: 0, width: 26.0/2.0, height: 26.0/2.0))
        removeBtn.center = CGPoint(x: 59.0, y: 1.0)
        removeBtn.backgroundColor = UIColor(red: 68.0/255.0, green: 68.0/255.0, blue: 68.0/255.0, alpha: 1)
        removeBtn.layer.cornerRadius = 26.0/4.0
        
        removeBtn.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_4))
        var sub1:UIView = UIView(frame: CGRect(x: 0, y: 0, width: 14.0/2.0, height: 2.0))
        sub1.center = CGPoint(x: 26.0/4.0 + 0.25, y: 26.0/4.0 - 0.25)
        sub1.backgroundColor = UIColor(red: 240.0/255.0, green: 113.0/255.0, blue: 88.0/255.0, alpha: 1)
        sub1.layer.cornerRadius = 1.0
        removeBtn.addSubview(sub1)
        var sub2:UIView = UIView(frame: CGRect(x: 0, y: 0, width: 2.0, height: 14.0/2.0))
        sub2.center = CGPoint(x: 26.0/4.0 + 0.25, y: 26.0/4.0 - 0.25)
        sub2.backgroundColor = UIColor(red: 240.0/255.0, green: 113.0/255.0, blue: 88.0/255.0, alpha: 1)
        sub2.layer.cornerRadius = 1.0
        removeBtn.alpha = 0.0
        removeBtn.addSubview(sub2)
        self.addSubview(removeBtn)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

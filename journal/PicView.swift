//
//  PicView.swift
//  journal
//
//  Created by wuyangbing on 14/11/10.
//  Copyright (c) 2014年 wuyangbing. All rights reserved.
//

import UIKit

class PicView: UIView {
    var imgInfo = ALAsset();
    var assert:AssetHelper = AssetHelper.sharedAssetHelper()
    override init(frame: CGRect) {
        var w = 30.0/2.0
        super.init(frame: frame)
        self.userInteractionEnabled = true
        self.clipsToBounds = false
        self.backgroundColor = UIColor.clearColor()
        var bg = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
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
        
        var imgLayer = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.width))
        imgLayer.backgroundColor = UIColor.clearColor()
        imgLayer.clipsToBounds = true
        self.addSubview(imgLayer)
        ///////////////////////////////
        var test = UIImageView(frame: CGRect(x: 0, y: 0, width: 120.0/2.0, height: 120.0/2.0))
        test.tag = 300
        test.center = CGPoint(x: 30, y: 30)
        imgLayer.addSubview(test)
        ////////////////////////////////
        var removeBtn = UIView(frame: CGRect(x: 0, y: 0, width: w, height: w))
        removeBtn.center = CGPoint(x: frame.width - 1.0, y: 1.0)
        removeBtn.backgroundColor = UIColor(red: 68.0/255.0, green: 68.0/255.0, blue: 68.0/255.0, alpha: 1)
        removeBtn.layer.cornerRadius = CGFloat(w/2.0)
        removeBtn.userInteractionEnabled = true
        removeBtn.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_4))
        var sub1:UIView = UIView(frame: CGRect(x: 0, y: 0, width: 18.0/2.0, height: 1.0))
        sub1.center = CGPoint(x: removeBtn.bounds.width/2.0, y: removeBtn.bounds.width/2.0)
        sub1.backgroundColor = UIColor(red: 240.0/255.0, green: 113.0/255.0, blue: 88.0/255.0, alpha: 1)
        removeBtn.addSubview(sub1)
        var sub2:UIView = UIView(frame: CGRect(x: 0, y: 0, width: 1.0, height: 18.0/2.0))
        sub2.center = CGPoint(x: removeBtn.bounds.width/2.0, y: removeBtn.bounds.width/2.0)
        sub2.backgroundColor = UIColor(red: 240.0/255.0, green: 113.0/255.0, blue: 88.0/255.0, alpha: 1)
        removeBtn.alpha = 0.0
        removeBtn.addSubview(sub2)
        var panGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tapdel")
        removeBtn.addGestureRecognizer(panGesture)
        
        self.addSubview(removeBtn)
    }
    func tapdel(){
        NSLog("tapdel")
    }
    func changeimg(asset:ALAsset) {
        imgInfo = asset
        let imgv = self.viewWithTag(300)!
        var img = assert.getImageFromAsset( imgInfo, type:Int(ASSET_PHOTO_THUMBNAIL) )
        (imgv as UIImageView).image = img
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

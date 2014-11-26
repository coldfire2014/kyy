//
//  perviewImg.swift
//  journal
//
//  Created by wuyangbing on 14/11/18.
//  Copyright (c) 2014年 wuyangbing. All rights reserved.
//

import UIKit

class perviewImg: UIView {
    var assert:AssetHelper = AssetHelper.sharedAssetHelper()
    var smallSize = CGSize()
    var bigSize = CGSize()
    var zframe = CGRect()
    init(frame: CGRect, initframe: CGRect, asset:ALAsset) {
        zframe = initframe
        super.init(frame:frame)
        self.backgroundColor = UIColor.clearColor()
        self.alpha = 1.0
        self.clipsToBounds = true
        var pan2Gesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "didbig")
        self.addGestureRecognizer(pan2Gesture)
        var img = assert.getImageFromAsset( asset, type:Int(ASSET_PHOTO_SCREEN_SIZE) )
        var iwidth = img.size.width
        var iheight = img.size.height
        var bkd = UIView(frame:frame)
        bkd.backgroundColor = UIColor.blackColor()
        bkd.alpha = 0.0
        bkd.tag = 204
        self.addSubview(bkd)
        var bk = UIView(frame:initframe)
        bk.tag = 205
        bk.clipsToBounds = true
        self.addSubview(bk)
        var imageView = UIImageView(image:img)
        bk.userInteractionEnabled = false
        imageView.tag = 206
        if iwidth > iheight {
            var h = initframe.height
            var w = iwidth / iheight * h
            smallSize = CGSize(width: w,height:h)
            imageView.frame = CGRect(x: -(w-initframe.width)/2.0, y: 0.0, width: w, height: h)
        }else{
            var w = initframe.width
            var h = iheight / iwidth * w
            smallSize = CGSize(width: w,height:h)
            imageView.frame = CGRect(x: 0, y: -(h-initframe.height)/2.0, width: w, height: h)
        }
        if (frame.height / frame.width) < (iheight / iwidth) {
            var h = frame.height
            var w = iwidth / iheight * h
            bigSize = CGSize(width: w,height:h)
        }else{
            var w = frame.width
            var h = iheight / iwidth * w
            bigSize = CGSize(width: w,height:h)
        }
        
        bk.addSubview(imageView)
        var pinchGesture:UIPinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: "didPinch:")
        bkd.addGestureRecognizer(pinchGesture)
        
        var panGesture:UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: "didPan:")
        bkd.addGestureRecognizer(panGesture)
        
//        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)];
//        [textOne addGestureRecognizer:panGesture];
//        
        
//        UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(didPinch:)];
//        [self.view addGestureRecognizer:pinchGesture];
        
        goCenter()
    }
    func goCenter(){
        if let bkd = self.viewWithTag(204){
            if let bk = self.viewWithTag(205){
                UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseInOut, animations: { () -> Void in
                        bkd.alpha = 1
                        bk.center = self.center
                    
                    }) { (Bool) -> Void in
                        bk.clipsToBounds = false
                        self.goBig()
                }
            }
        }
    }
    func goBig(){
        let bk = self.viewWithTag(205)!
        bk.bounds = CGRect(origin:CGPointZero,size:self.bigSize)
        let img = bk.viewWithTag(206)!
        img.center = CGPoint(x:self.bigSize.width/2.0,y:self.bigSize.height/2.0)
        img.bounds = CGRect(origin:CGPointZero,size:self.bigSize)
        var obj:Int = BarShowType.OnlyNav.rawValue
        NSNotificationCenter.defaultCenter().postNotificationName(MSG_BAR_HIDE, object: obj)
        
        var t:CATransform3D = CATransform3DIdentity
        var d = smallSize.height / bigSize.height
        if smallSize.width > smallSize.height {
            d = smallSize.width / bigSize.width
        }
        
        let moveAnim:CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "transform")
        moveAnim.values = [NSValue(CATransform3D: CATransform3DMakeScale(d,d,1.0)),NSValue(CATransform3D: CATransform3DMakeScale(1.3,1.3,1.0)),NSValue(CATransform3D: CATransform3DMakeScale(0.9,0.9,1.0)),NSValue(CATransform3D: CATransform3DMakeScale(1.04,1.04,1.0)),NSValue(CATransform3D: CATransform3DMakeScale(0.99,0.99,1.0)),NSValue(CATransform3D: t)];
        moveAnim.removedOnCompletion = true

        let opacityAnim:CABasicAnimation = CABasicAnimation(keyPath: "alpha")
        opacityAnim.fromValue = NSNumber(float: 1.0)
        opacityAnim.toValue = NSNumber(float: 1.0)
        opacityAnim.removedOnCompletion = true
        
        let animGroup:CAAnimationGroup = CAAnimationGroup()
        animGroup.animations = [moveAnim,opacityAnim]
        animGroup.duration = 0.5
        animGroup.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animGroup.removedOnCompletion = true
        animGroup.fillMode = kCAFillModeForwards
        img.layer.addAnimation(animGroup, forKey: "s")
    }
    func didbig(){
        self.userInteractionEnabled = false
        var obj:Int = BarShowType.OnlyNav.rawValue
        NSNotificationCenter.defaultCenter().postNotificationName(MSG_BAR_SHOW, object: obj)
        let bk = self.viewWithTag(205)!
        let img = bk.viewWithTag(206)!
        var d = smallSize.height / bigSize.height
        if smallSize.width > smallSize.height {
            d = smallSize.width / bigSize.width
        }
        UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseInOut, animations: { () -> Void in
            img.layer.transform = CATransform3DMakeScale(d,d,1.0)
            
            }) { (Bool) -> Void in
                bk.clipsToBounds = true
                bk.bounds = CGRect(origin:CGPointZero,size:self.zframe.size)
                img.center = CGPoint(x:self.zframe.size.width/2.0,y:self.zframe.size.height/2.0)
                self.goSmall()
                self.userInteractionEnabled = true
        }
    }
    func goSmall(){
        let bkd = self.viewWithTag(204)!
        let bk = self.viewWithTag(205)!
        UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseInOut, animations: { () -> Void in
            bkd.alpha = 0
            bk.frame = self.zframe
            
            }) { (Bool) -> Void in
                self.removeFromSuperview()
        }
    }
    var t = CATransform3DIdentity
    func didPinch(g:UIPinchGestureRecognizer){
        let bk = self.viewWithTag(205)!
        let img = bk.viewWithTag(206)!
        switch(g.state){
        case .Began:
            t = img.layer.transform
        case .Cancelled, .Ended:
            var ts = img.layer.transform.m11
            if ts < 1.0 {
                didbig()
            }else if ts > 2.0 {
                img.layer.transform.m11 = 2.0
                img.layer.transform.m22 = 2.0
            }
            miChangeImg()
        default:
            img.layer.transform = CATransform3DScale(t, g.scale, g.scale, 1.0)
        }
    }
    func miChangeImg(){
        
    }
    var firstTranslation:CGPoint = CGPoint()
    var previousTranslation:CGPoint = CGPoint()
    func didPan(g:UIPanGestureRecognizer){
        let bkd = self.viewWithTag(204)!
        let bk = self.viewWithTag(205)!
        let img = bk.viewWithTag(206)!
        switch(g.state){
        case .Began:
            firstTranslation = g.translationInView(bkd)
            previousTranslation = g.translationInView(bkd)
            t = img.layer.transform
        case .Cancelled, .Ended:
            t = img.layer.transform
        default:
            var tmp = g.translationInView(bkd)
            var yt:CGFloat = tmp.y - previousTranslation.y
            var xt:CGFloat = tmp.x - previousTranslation.x
            
            var cp = CGPoint(x: (img.frame.origin.x + img.frame.width)/2.0 + xt, y: (img.frame.origin.y+img.frame.height)/2.0 + yt)

            if 0 > cp.x || bkd.frame.width < cp.x {
                tmp.x = previousTranslation.x
            }
            if 0 > cp.y || bkd.frame.height < cp.y {
                tmp.y = previousTranslation.y
            }
            yt = tmp.y - previousTranslation.y
            xt = tmp.x - previousTranslation.x
            img.layer.transform = CATransform3DTranslate(img.layer.transform, xt, yt, 0)
            previousTranslation = tmp
        }
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//    var myDelegate: NSWindowDelegate? = MyDelegate()
//    if let fullScreenSize = myDelegate?.window?(myWindow, willUseFullScreenContentSize: mySize) {
//        println(NSStringFromSize(fullScreenSize))
//    }

}

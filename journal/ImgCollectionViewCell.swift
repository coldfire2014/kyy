//
//  ImgCollectionViewCell.swift
//  journal
//
//  Created by wuyangbing on 14/11/12.
//  Copyright (c) 2014年 wuyangbing. All rights reserved.
//

import UIKit

class ImgCollectionViewCell: UICollectionViewCell {
    var index:NSIndexPath = NSIndexPath()
    var asset:ALAsset = ALAsset()
    var maxCount = -1
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.greenColor()
        var img = myImageView(frame: self.bounds)
        img.tag = 202
        self.addSubview(img)
        var w:Double = Double(frame.height) / 4.0
        var btn:UIView = UIView(frame: CGRect(x: 0, y: 0, width: w*1.6, height: w*1.6))
        btn.backgroundColor = UIColor(white: 0.5, alpha: 0.0)
        btn.center = CGPoint(x: 3.2*w, y: 0.8*w)
        var bg:UIView = UIView(frame: CGRect(x: w*0.3, y: w*0.3, width: w, height: w))
        bg.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        bg.layer.cornerRadius = CGFloat(w/2.0)
        btn.addSubview(bg)
        var wc = UIView(frame: CGRect(x: 1.0, y: 1.0, width: w-2.0, height: w-2.0))
        wc.layer.borderWidth = 1
        wc.layer.cornerRadius = CGFloat((w-2.0)/2.0)
        wc.layer.borderColor = UIColor(white: 1.0, alpha: 1.0).CGColor
        bg.addSubview(wc)
        var gc = UIView(frame: CGRect(x: 0.0, y: 0.0, width: w, height: w))
        gc.layer.cornerRadius = CGFloat(w/2.0)
        gc.backgroundColor = UIColor(red: 54.0/255.0, green: 215.0/255.0, blue: 79.0/255.0, alpha: 1.0 )
        gc.tag = 203
        gc.hidden = true
        bg.addSubview(gc)
        
        var gx = UIView(frame: CGRect(x: 0.0, y: 0.0, width: w/4.0, height: 2.0))
        gx.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        gx.center = CGPoint(x: 0.5*w + 0.5, y: 0.5*w - 0.5)
        gx.layer.transform = CATransform3DTranslate(gx.layer.transform, CGFloat(-w/4.0), CGFloat(1.0), 0)
        gx.layer.transform = CATransform3DRotate(gx.layer.transform, CGFloat(M_PI_2), 0, 0, 1)
        
        bg.addSubview(gx)
        var gs = UIView(frame: CGRect(x: 0.0, y: 0.0, width: w/1.7 - 2.0, height: 2.0))
        gs.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        gs.center = CGPoint(x: 0.5*w + 0.7, y: 0.5*w - 0.5)
        gs.layer.transform = CATransform3DTranslate(gs.layer.transform, CGFloat(0.0), CGFloat(w/8.0), 0)
        bg.addSubview(gs)
        bg.layer.transform = CATransform3DRotate(btn.layer.transform, CGFloat(-M_PI_4), 0, 0, 1)
        btn.tag=201
        self.addSubview(btn)
        var panGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "didtap")
        btn.addGestureRecognizer(panGesture)
        var pan2Gesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "didprev:")
        self.addGestureRecognizer(pan2Gesture)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func didprev( t:UITapGestureRecognizer){
        var p = t.locationInView(self)
        var pc = t.locationInView(self.superview?.superview)
        var r = CGRect(origin:CGPoint(x:self.frame.origin.x,y:(pc.y-p.y)), size:self.frame.size)// self.frame.offset(0,self.superview!.frame.origin.y)
        var img = perviewImg(frame:UIScreen.mainScreen().bounds,initframe: r,asset: asset)
        
        self.window?.addSubview(img)
    }
    func didtap(){
        var btnnil = self.viewWithTag(201)
        if let btn = btnnil{
            if let gc = btn.viewWithTag(203){
            
                if (gc.hidden) {
                    var cv = (self.superview as UICollectionView)
                    var ips = cv.indexPathsForSelectedItems()
                    if ips?.count < maxCount {
                        cv.selectItemAtIndexPath(index,animated:true, scrollPosition:UICollectionViewScrollPosition.None)
                        gc.hidden = !gc.hidden
                        var t:CATransform3D = CATransform3DIdentity
                        let moveAnim:CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "transform")
                        moveAnim.values = [NSValue(CATransform3D: CATransform3DScale(t, 1.3, 1.3, 1)),NSValue(CATransform3D: CATransform3DScale(t, 0.8, 0.8, 1)),NSValue(CATransform3D: CATransform3DScale(t, 1.1, 1.1, 1)),NSValue(CATransform3D: t)];
                        moveAnim.removedOnCompletion = true
                        moveAnim.duration = 0.5
                        moveAnim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                        moveAnim.removedOnCompletion = true
                        moveAnim.fillMode = kCAFillModeForwards
                        btn.layer.addAnimation(moveAnim, forKey: "s")
                    }else{
                        NSNotificationCenter.defaultCenter().postNotificationName(MSG_ALERT, object: "最多只能选\(maxCount)张哦 !")
                    }
                }else{
                    (self.superview as UICollectionView).deselectItemAtIndexPath(index,animated:true)
                    UIView.animateWithDuration(0.2, delay: 0, options: .CurveEaseInOut, animations: { () -> Void in
                            gc.alpha = 0
                        }) { (Bool) -> Void in
                            gc.hidden = !gc.hidden
                            gc.alpha = 1
                    }
                }
            }
            else{
                NSLog("gc=null")
            }
        }
        else{
            NSLog("btn=null")
        }
    }
}

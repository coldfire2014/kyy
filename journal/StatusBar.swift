//
//  StatusBar.swift
//  journal
//
//  Created by wuyangbing on 14/11/2.
//  Copyright (c) 2014年 wuyangbing. All rights reserved.
//

import UIKit

class StatusBar: UIWindow {

    var msg1:UILabel = UILabel()
    var msg2:UILabel = UILabel()
    var bk:UIView = UIView()
    
    override convenience init() {
        self.init(frame: CGRect.zeroRect)
    }
    override init(frame: CGRect) {
        super.init(frame:frame)
        var statusBarFrame:CGRect = UIApplication.sharedApplication().statusBarFrame
        statusBarFrame.size.height = (statusBarFrame.size.height == 40.0) ? 20.0 : statusBarFrame.size.height
        windowLevel = UIWindowLevelStatusBar+1.0
        self.frame = statusBarFrame;
        self.backgroundColor = UIColor.clearColor()
        self.alpha = 1.0
        self.hidden = false;
        bk.frame = CGRectMake(self.frame.size.width, 0, self.frame.size.width, 20)
        bk.backgroundColor = UIColor(red: 39.0/255.0, green: 136.0/255.0, blue: 231.0/255.0, alpha: 1.0)
        bk.layer.cornerRadius = 10.0
        self.addSubview(bk)
        msg1.frame = CGRectMake(7, 0, 140, 20)
        msg1.font = UIFont.systemFontOfSize(13.0)
        msg1.textAlignment = .Left
        msg1.textColor = UIColor.whiteColor()
        msg1.backgroundColor = UIColor.clearColor()
        msg1.text = ""
        bk.addSubview(msg1)
        var panGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "didtap")
        bk.addGestureRecognizer(panGesture)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    class func shareInstance()->StatusBar{
        struct Singleton{
            static var predicate:dispatch_once_t = 0
            static var instance:StatusBar? = nil
        }
        dispatch_once(&Singleton.predicate,{
            Singleton.instance=StatusBar()
            }
        )
        return Singleton.instance!
    }
    func didtap(){
        goout(0)
    }
    func goout(time:Double){
        if self.alpha == 1.0 {
            UIView.animateWithDuration(0.3, delay: time, options: .CurveEaseInOut, animations: { () -> Void in
                self.alpha = 0
                }) { (Bool) -> Void in
                    
            }
        }
    }
    func talkMsg(msg:String,time:Double){
        self.alpha = 1.0
        msg1.frame = CGRect(origin: msg1.frame.origin, size: CGSize(width: self.frame.size.width, height: msg1.frame.size.height))
        msg1.text = msg
        msg1.sizeToFit()
        msg1.frame = CGRect(origin: msg1.frame.origin, size: CGSize(width: msg1.frame.size.width, height: 20.0))
        var ww = msg1.frame.width + 16.0
        bk.frame = CGRectMake(self.frame.size.width-ww, 0, self.frame.size.width, 20)
        var animation:CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "position")
        
        var values = [NSValue(CGPoint: CGPoint(x:self.frame.size.width*1.5, y:10.0)),
            NSValue(CGPoint: CGPoint(x:self.frame.size.width*1.5-ww-12.0, y:10.0)),
            NSValue(CGPoint: CGPoint(x:self.frame.size.width*1.5-ww+6.0, y:10.0)),
            NSValue(CGPoint: CGPoint(x:self.frame.size.width*1.5-ww, y:10.0))]
        animation.values = values
        animation.duration = 0.5
        animation.removedOnCompletion = true
        animation.fillMode = kCAFillModeForwards
        bk.layer.addAnimation(animation, forKey: "")
        goout(0.5+time)
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
        // Drawing code
    }
    */

}

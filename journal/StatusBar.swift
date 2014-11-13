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
        bk.frame = CGRectMake(self.frame.size.width, 0, 160, 20)
        bk.backgroundColor = UIColor.lightGrayColor()
        bk.layer.cornerRadius = 10.0
        self.addSubview(bk)
        msg1.frame = CGRectMake(10, 0, 140, 20)
        msg1.font = UIFont.systemFontOfSize(15.0)
        msg1.textAlignment = .Left
        msg1.textColor = UIColor.blackColor()
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
        UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseInOut, animations: { () -> Void in
            self.alpha = 0
        }) { (Bool) -> Void in
            
        }
    }
    func talkMsg(msg:String,time:Float){
        self.alpha = 1.0
        msg1.text = msg
        bk.frame = CGRectMake(self.frame.size.width-70.0-85, 0, 170, 20)
        var animation:CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "position")
        
        var values = [NSValue(CGPoint: CGPoint(x:self.frame.size.width+85.0, y:10.0)),
            NSValue(CGPoint: CGPoint(x:self.frame.size.width-80.0, y:10.0)),
            NSValue(CGPoint: CGPoint(x:self.frame.size.width-65.0, y:10.0)),
            NSValue(CGPoint: CGPoint(x:self.frame.size.width-70.0, y:10.0))]
        animation.values = values
        animation.duration = 0.5
        animation.removedOnCompletion = true
        animation.fillMode = kCAFillModeForwards
        bk.layer.addAnimation(animation, forKey: "")
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

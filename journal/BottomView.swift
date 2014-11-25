//
//  BottomView.swift
//  journal
//
//  Created by wuyangbing on 14/11/10.
//  Copyright (c) 2014年 wuyangbing. All rights reserved.
//

import UIKit

class BottomView: UIWindow {
    var title:UILabel = UILabel()
    let newTitle = "新建杂志"
    let editTitle = "编辑杂志"
    var showframe = CGRectZero
    var hideframe = CGRectZero
    override init(frame: CGRect) {
        super.init(frame:frame)
        windowLevel = UIWindowLevelNormal+1.0
        self.frame = frame;
        showframe = frame
        hideframe = CGRectOffset(frame, 0, frame.height)
        self.backgroundColor = UIColor.clearColor()
        self.alpha = 1.0
        self.hidden = false;

        var bk = UIView(frame: CGRect(origin: CGPointZero, size: frame.size))
        bk.backgroundColor = UIColor.clearColor()
        let layer:CAGradientLayer = CAGradientLayer()
        layer.frame = CGRect(origin: CGPointZero, size: CGSize(width: frame.size.height, height: frame.size.width))
        layer.position = bk.center
        layer.transform = CATransform3DMakeRotation(CGFloat( -M_PI_2 ), 0, 0, 1)
        layer.colors = [UIColor(red: 35.0/255.0, green: 21.0/255.0, blue: 111.0/255.0, alpha: 1).CGColor,
            UIColor(red: 41.0/255.0, green: 58.0/255.0, blue: 128.0/255.0, alpha: 1).CGColor,
            UIColor(red: 75.0/255.0, green: 139.0/255.0, blue: 188.0/255.0, alpha: 1).CGColor]
        layer.locations = [0,0.35,1]
        bk.layer.addSublayer(layer)
        
        self.addSubview(bk)
        title.frame = CGRect(x: 0, y: 0.0, width: frame.size.width, height: frame.size.height)
        title.font = UIFont.systemFontOfSize(12)
        title.textAlignment = .Center
        title.textColor = UIColor.whiteColor()
        title.backgroundColor = UIColor.clearColor()
        bk.addSubview(title)
        var panGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "didtap")
        bk.addGestureRecognizer(panGesture)
        var top = (frame.size.height - 88.0/2.0)/2.0
        var btnRight = UIView(frame: CGRect(x: frame.size.width - top - 88.0/2.0, y: top, width: 88.0/2.0, height: 88.0/2.0))
        btnRight.backgroundColor = UIColor.clearColor()
//        btnRight.layer.cornerRadius = 88.0/4.0
        bk.addSubview(btnRight)
    }
    func show(show:Bool){
        UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseInOut, animations: { () -> Void in
            if(show){
                self.frame = self.showframe
            }else{
                self.frame = self.hideframe
            }
            }) { (Bool) -> Void in

        }
    }

    func changeTitle(title:String){
        UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseInOut, animations: { () -> Void in
            self.title.text = title
            }) { (Bool) -> Void in
                
        }
    }
    func didtap(){
//        NSNotificationCenter.defaultCenter().postNotificationName(MSG_GOBACK_ALL, object: nil)
//        UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseInOut, animations: { () -> Void in
////            self.alpha = 0
//            }) { (Bool) -> Void in
//                
//        }
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

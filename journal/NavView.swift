//
//  NavView.swift
//  journal
//
//  Created by wuyangbing on 14/11/10.
//  Copyright (c) 2014年 wuyangbing. All rights reserved.
//

import UIKit
enum btnTypes : Int {
    
    case Edit //
    
    case Img //
    
    case UserList //
    
    case SetupList
}

class NavView: UIWindow {
    
    var title:UILabel = UILabel()
//    var btnLeft:myImageView = myImageView(frame: CGRect.zeroRect)
//    var btnRight:myImageView = myImageView(frame: CGRect.zeroRect)
//    var exitBtn:myImageView = myImageView(frame: CGRect.zeroRect)
    var btnType:btnTypes = .Edit
    var backType:btnTypes = .Edit
    var setupView:UIView = UIView()
    override init(frame: CGRect) {
        super.init(frame:frame)
        windowLevel = UIWindowLevelNormal+2.0
        self.frame = frame;
        self.backgroundColor = UIColor.clearColor()
        self.alpha = 1.0
        self.hidden = false;
        var bk:myImageView = myImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height), name: "top", scale: 2.0)
        bk.tag = 101
        self.addSubview(bk)
        title.frame = CGRect(x: 0, y: 20.0, width: frame.size.width, height: frame.size.height-20.0)
        title.font = UIFont.systemFontOfSize(15)
        title.textAlignment = .Center
        title.textColor = UIColor.whiteColor()
        title.backgroundColor = UIColor.clearColor()
        title.text = "快发布"
        bk.addSubview(title)
        var btnLeft = myImageView(frame: CGRect(x: 0, y: 20.0, width: 44.0, height: 44.0), name: "T1", scale: 2.0)
        btnLeft.tag = 102
        bk.addSubview(btnLeft)
        var btnRight = myImageView(frame: CGRect(x: bk.frame.size.width-44.0, y: 20.0, width: 44.0, height: 44.0), name: "T5", scale: 2.0)
        btnRight.tag = 103
        bk.addSubview(btnRight)
        
        btnLeft.setBadgeValue(0)
        btnRight.setBadgeValue(2)
        
        var panGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "other")
        btnRight.addGestureRecognizer(panGesture)
        var panGesture3:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "back")
        btnLeft.addGestureRecognizer(panGesture3)
        
        //markwyb 设置
        setupView.frame = CGRect(x: 0, y: -680.0/2.0, width: frame.size.width, height: 680.0/2.0)
        setupView.backgroundColor = UIColor(red: 0, green: 153.0/255.0, blue: 204.0/255.0, alpha: 1)
        setupView.clipsToBounds = true
        setupView.userInteractionEnabled = true
        var setupTitle = UILabel(frame: CGRect(x: 0, y: 20.0, width: frame.size.width, height: frame.size.height-20.0))
        setupTitle.font = UIFont.systemFontOfSize(15)
        setupTitle.textAlignment = .Center
        setupTitle.textColor = UIColor.whiteColor()
        setupTitle.backgroundColor = UIColor.clearColor()
        setupTitle.text = "系统设置"
        setupView.addSubview(setupTitle)
        var size = CGSize(width: frame.size.width, height: 80.0/2.0)
        var btn1:setupCell = setupCell(frame: CGRect(origin: CGPoint(x: 0, y: 128.0/2.0), size: size), name: "我的杂志", iconName: "A3")
        setupView.addSubview(btn1)
        var btn2:setupCell = setupCell(frame: CGRect(origin: CGPoint(x: 0, y: 128.0/2.0+80.0/2.0), size: size), name: "系统消息", iconName: "A5")
        setupView.addSubview(btn2)
        var btn3:setupCell = setupCell(frame: CGRect(origin: CGPoint(x: 0, y: 128.0/2.0+2.0*80.0/2.0), size: size), name: "意见反馈", iconName: "A4")
        setupView.addSubview(btn3)
        var btn4:setupCell = setupCell(frame: CGRect(origin: CGPoint(x: 0, y: 128.0/2.0+3.0*80.0/2.0), size: size), name: "绑定账号", iconName: "A1")
        setupView.addSubview(btn4)
        var btn5:setupCell = setupCell(frame: CGRect(origin: CGPoint(x: 0, y: 128.0/2.0+4.0*80.0/2.0), size: size), name: "分享我们", iconName: "A2")
        setupView.addSubview(btn5)
        self.addSubview(setupView)
        
        var btnExit = myImageView(frame: CGRect(x: bk.frame.size.width-44.0, y: 20.0, width: 44.0, height: 44.0), name: "T3", scale: 2.0)
        setupView.addSubview(btnExit)
        var panGesture2:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "other")
        btnExit.addGestureRecognizer(panGesture2)
    }
    func show(show:Bool){
        UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseInOut, animations: { () -> Void in
            if(show){
                self.frame.offset(dx: 0, dy: 128.0/2.0)
            }else{
                self.frame.offset(dx: 0, dy: -128.0/2.0)
            }
            }) { (Bool) -> Void in
                
        }
    }
    var isLeftTap = true
    func back(){
        isLeftTap = true
        var t:CATransform3D = CATransform3DIdentity
        let moveAnim:CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "transform")
        moveAnim.values = [NSValue(CATransform3D: CATransform3DScale(t, 1.2, 1.2, 1)),NSValue(CATransform3D: CATransform3DScale(t, 0.9, 0.9, 1)),NSValue(CATransform3D: t)];
        moveAnim.removedOnCompletion = true
        moveAnim.duration = 0.3
        moveAnim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        moveAnim.removedOnCompletion = true
        moveAnim.fillMode = kCAFillModeForwards
        moveAnim.delegate = self
        if let btnLeft = self.viewWithTag(102){
            btnLeft.layer.addAnimation(moveAnim, forKey: "left")
        }
    }
    func other(){
        if btnTypes.SetupList == btnType {
            setupHide()
        }
        isLeftTap = false
        var t:CATransform3D = CATransform3DIdentity
        let moveAnim:CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "transform")
        moveAnim.values = [NSValue(CATransform3D: CATransform3DScale(t, 1.2, 1.2, 1)),NSValue(CATransform3D: CATransform3DScale(t, 0.9, 0.9, 1)),NSValue(CATransform3D: t)];
        moveAnim.removedOnCompletion = true
        moveAnim.duration = 0.3
        moveAnim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        moveAnim.removedOnCompletion = true
        moveAnim.fillMode = kCAFillModeForwards
        moveAnim.delegate = self
        if let btnRight = self.viewWithTag(103){
            btnRight.layer.addAnimation(moveAnim, forKey: "right")
        }
    }
    override func animationDidStop(anim:CAAnimation ,finished flag:Bool){
        if flag {
            if isLeftTap {
                doback()
            }else{
                doother()
            }
        }
    }
    func doback(){
        
        switch btnType {
        case btnTypes.Edit:
            goMain()
        case btnTypes.UserList:
            btnType = btnTypes.Edit
            backEditfromlist()
        case btnTypes.Img:
            btnType = btnTypes.Edit
            backEditfromImg()
        default:
            break
        }

    }
    func doother(){
        
        switch btnType {
        case btnTypes.Edit:
            goSetup()
        case btnTypes.UserList:
            goSetup()
        case btnTypes.Img:
            goImgOK()
        case btnTypes.SetupList:
            btnType = backType
            NSNotificationCenter.defaultCenter().postNotificationName(MSG_SETUP_DESELECT, object: "")
        default:
            break
        }
    }
    func doSetupBy(s:String){
        switch s {
        case "A3":
            title.text = "我发布的"
            btnType = btnTypes.UserList
            NSNotificationCenter.defaultCenter().postNotificationName(MSG_MY_SHOW, object: nil)
        default:
            btnType = backType
//            title.text = "快发布"
            //btnType = btnTypes.Edit
        }
        setupHide()
    }
    func backEditfromlist(){
        title.text = "快发布"
        NSNotificationCenter.defaultCenter().postNotificationName(MSG_BACK, object: nil)
        NSNotificationCenter.defaultCenter().postNotificationName(MSG_SETUP_DESELECT, object: "")
    }
    func backEditfromImg(){
        NSNotificationCenter.defaultCenter().postNotificationName(MSG_BACK, object: nil)
        NSNotificationCenter.defaultCenter().postNotificationName(MSG_IMG_SELECT_HIDE, object: nil)
        img2edit()
    }
    func goImgOK(){
        backEditfromImg()
    }

    func goMain(){
        
    }
    
    func img2edit(){
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.title.text = "快发布"
            if let btnLeft = self.viewWithTag(102){
                (btnLeft as myImageView).changeImg("T1", scale: 2.0)
            }
            if let btnRight = self.viewWithTag(103){
                (btnRight as myImageView).changeImg("T5", scale: 2.0)
            }
            self.btnType = btnTypes.Edit
        })
    }
    func change2img(){
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.title.text = "照片胶卷"
            if let btnLeft = self.viewWithTag(102){
                (btnLeft as myImageView).changeImg("T3", scale: 2.0)
            }
            if let btnRight = self.viewWithTag(103){
                (btnRight as myImageView).changeImg("T4", scale: 2.0)
            }
            self.btnType = btnTypes.Img
        })
    }
    func leftBtnShow(show:Bool,delay:Double){
        if let btnLeft = self.viewWithTag(102){
            UIView.animateWithDuration(0.3, delay: delay, options: .CurveEaseInOut, animations: { () -> Void in
                var lf:CGRect = btnLeft.frame
                if !show {
                    btnLeft.frame = CGRect(x: -lf.size.width, y: 20.0, width: lf.size.width, height: lf.size.height)
                }else{
                    btnLeft.frame = CGRect(x: 0, y: 20.0, width: lf.size.width, height: lf.size.height)
                }
                }) { (Bool) -> Void in
            }
        }
    }
    func goSetup(){
        backType = btnType
        btnType = btnTypes.SetupList
        setupShow()
        leftBtnShow(false, delay: 0)
    }
    func setupHide(){
        setuphide()
        leftBtnShow(true, delay: 0.3)
    }
    func setuphide(){
        if let bk = self.viewWithTag(101){
            UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseInOut, animations: { () -> Void in
                for i in self.setupView.subviews{
                    (i as UIView).layer.transform = CATransform3DMakeRotation(CGFloat(-M_PI_2), 1, 0, 0)
                    (i as UIView).alpha = 0
                }
                }) { (Bool) -> Void in
                    
            }
            UIView.animateWithDuration(0.15, delay: 0.2, options: .CurveEaseInOut, animations: { () -> Void in
                self.setupView.frame = CGRect(x: 0, y: -bk.frame.size.height, width: bk.frame.size.width, height: bk.frame.size.height)
                }) { (Bool) -> Void in
                    
            }
            UIView.animateWithDuration(0.15, delay: 0.5, options: .CurveEaseInOut, animations: { () -> Void in
                self.backgroundColor = UIColor.clearColor()
                }) { (Bool) -> Void in
                    self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.width, height: bk.frame.size.height)
                    self.setupView.frame = CGRect(x: 0, y: -680.0/2.0, width: self.setupView.frame.size.width, height: 680.0/2.0)
            }
        }
    }

    func setupShow(){
        var f = UIScreen.mainScreen().bounds.size;
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.width, height: f.height)
        UIView.animateWithDuration(0.15, delay: 0, options: .CurveEaseInOut, animations: { () -> Void in
            self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
            }) { (Bool) -> Void in
                
        }
        UIView.animateWithDuration(0.2, delay: 0.3, options: .CurveEaseInOut, animations: { () -> Void in
            self.setupView.frame = CGRect(x: 0, y: 0, width: self.setupView.frame.size.width, height: 680.0/2.0)
            }) { (Bool) -> Void in
                
        }
        UIView.animateWithDuration(0.2, delay: 0.5, options: .CurveEaseInOut, animations: { () -> Void in
            for i in self.setupView.subviews{
                (i as UIView).layer.transform = CATransform3DIdentity
                (i as UIView).alpha = 1
            }
            }) { (Bool) -> Void in
               self.setupView.frame = CGRect(x: 0, y: 0, width: self.setupView.frame.size.width, height: 680.0/2.0)
        }
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//        var setupID = (self.subviews as NSArray).indexOfObject(setupView)
//        var bkID = (self.subviews as NSArray).indexOfObject(bk)
//        self.exchangeSubviewAtIndex(setupID, withSubviewAtIndex: bkID)
//        var animation:CATransition = CATransition()
//        animation.delegate = self;
//        animation.duration = 0.5;
//        animation.timingFunction = CAMediaTimingFunction( name: kCAMediaTimingFunctionEaseInEaseOut)
//        animation.type = "oglFlip"
//        animation.subtype = kCATransitionFromTop;
//        bk.exchangeSubviewAtIndex(bkID, withSubviewAtIndex: setupID)
//        self.layer.addAnimation(animation, forKey: "animation")
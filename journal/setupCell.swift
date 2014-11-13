//
//  setupCell.swift
//  journal
//
//  Created by wuyangbing on 14/11/11.
//  Copyright (c) 2014年 wuyangbing. All rights reserved.
//

import UIKit

class setupCell: UIView {
    var iconname = ""
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    init(frame: CGRect, name:String! ,iconName:String!) {
        iconname = iconName
        super.init(frame: frame)
        self.clipsToBounds = true
        userInteractionEnabled = true
        self.layer.transform = CATransform3DMakeRotation(CGFloat(-M_PI_2), 1, 0, 0)
        self.alpha = 0
        backgroundColor = UIColor.clearColor()
        var icon = myImageView(frame: CGRect(x: 24.0/2.0, y: -4.0/2.0, width: 88.0/2.0, height: 88.0/2.0), name: iconName, scale: 2.0)
        self.addSubview(icon)
        var setupTitle = UILabel(frame: CGRect(x: 140.0/2.0, y: 0.0, width: frame.size.width, height: frame.size.height))
        setupTitle.font = UIFont.systemFontOfSize(15)
        setupTitle.textAlignment = .Left
        setupTitle.textColor = UIColor.whiteColor()
        setupTitle.backgroundColor = UIColor.clearColor()
        setupTitle.text = name
        self.addSubview(setupTitle)
        var b = UIView(frame: CGRect(x: 24.0/2.0, y: frame.size.height-1, width: frame.size.width-24.0, height: 1))
        b.backgroundColor = UIColor(white: 1, alpha: 0.1)
        self.addSubview(b)
        var panGesture2:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "doSetup")
        self.addGestureRecognizer(panGesture2)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "changeUI:", name: MSG_SETUP_DESELECT, object: nil)
    }
    func doSetup(){
        NSNotificationCenter.defaultCenter().postNotificationName(MSG_SETUP_DESELECT, object: iconname)
        UIView.animateWithDuration(0.1, delay: 0.0, options: .CurveEaseInOut, animations: { () -> Void in
            self.backgroundColor = UIColor(red: 0, green: 102.0/255.0, blue: 153.0/255.0, alpha: 1)
            }) { (Bool) -> Void in
                
        }
    }
    func changeUI(no:NSNotification){
        var s = no.object as String
        if s != iconname {
            UIView.animateWithDuration(0.1, delay: 0.0, options: .CurveEaseInOut, animations: { () -> Void in
                self.backgroundColor = UIColor.clearColor()
                }) { (Bool) -> Void in
                    
            }
        }
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

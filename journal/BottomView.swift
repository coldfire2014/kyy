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
    override init(frame: CGRect) {
        super.init(frame:frame)
        windowLevel = UIWindowLevelNormal+1.0
        self.frame = frame;
        self.backgroundColor = UIColor.clearColor()
        self.alpha = 1.0
        self.hidden = false;
        var bk = myImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height), name: "bottom", scale: 2.0)
        self.addSubview(bk)
        title.frame = CGRect(x: 0, y: 0.0, width: frame.size.width, height: frame.size.height)
        title.font = UIFont.systemFontOfSize(12)
        title.textAlignment = .Center
        title.textColor = UIColor.whiteColor()
        title.backgroundColor = UIColor.clearColor()
        bk.addSubview(title)
        var panGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "didtap")
        bk.addGestureRecognizer(panGesture)
    }
    func show(show:Bool){
        UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseInOut, animations: { () -> Void in
            if(show){
                self.frame.offset(dx: 0, dy: -98.0/2.0)
            }else{
                self.frame.offset(dx: 0, dy: 98.0/2.0)
            }
            }) { (Bool) -> Void in

        }
    }

    func changeTitle(isNew:Bool){
        UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseInOut, animations: { () -> Void in
            if(isNew){
                self.title.text = self.newTitle
            }else{
                self.title.text = self.editTitle
            }
            }) { (Bool) -> Void in
                
        }
    }
    func didtap(){
        UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseInOut, animations: { () -> Void in
//            self.alpha = 0
            }) { (Bool) -> Void in
                
        }
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

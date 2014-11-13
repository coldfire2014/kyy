//
//  MusicInput.swift
//  journal
//
//  Created by wuyangbing on 14/11/10.
//  Copyright (c) 2014年 wuyangbing. All rights reserved.
//

import UIKit

class MusicInput: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        userInteractionEnabled = true
        var titled:UILabel = UILabel()
        titled.frame = CGRect(x: 36.0/2.0, y: 0.0/2.0, width: frame.size.width, height: 80.0/2.0)
        titled.font = UIFont.systemFontOfSize(12)
        titled.textAlignment = .Left
        titled.textColor = UIColor(red: 188.0/255.0, green: 194.0/255.0, blue: 202.0/255.0, alpha: 1 )
        titled.backgroundColor = UIColor.clearColor()
        titled.text = "添加或修改背景音乐"
        self.addSubview(titled)
        
        var desBg:UIView = UIView(frame: CGRect(x: 36.0/2.0, y: 70.0/2.0, width: frame.size.width - 36.0, height: 55.0/2.0))
        desBg.backgroundColor = UIColor(red: 225.0/255.0, green: 246.0/255.0, blue: 254.0/255.0, alpha:0.5)
        self.addSubview(desBg)
        
        var titlem:UILabel = UILabel()
        titlem.frame = CGRect(x: 0.0, y: 0.0, width: frame.size.width - 36.0, height: 55.0/2.0)
        titlem.font = UIFont.systemFontOfSize(12)
        titlem.textAlignment = .Center
        titlem.textColor = UIColor(red: 188.0/255.0, green: 194.0/255.0, blue: 202.0/255.0, alpha: 1 )
        titlem.backgroundColor = UIColor.clearColor()
        titlem.text = "背景音乐"
        desBg.addSubview(titlem)
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  InfoInput.swift
//  journal
//
//  Created by wuyangbing on 14/11/10.
//  Copyright (c) 2014年 wuyangbing. All rights reserved.
//

import UIKit

class InfoInput: UIView {
    var count:UILabel = UILabel()
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
        self.backgroundColor = UIColor.clearColor()
        var title:UILabel = UILabel()
        title.frame = CGRect(x: 36.0/2.0, y: 308.0/2.0, width: frame.size.width, height: 70.0/2.0)
        title.font = UIFont.systemFontOfSize(12)
        title.textAlignment = .Left
        title.textColor = UIColor(red: 188.0/255.0, green: 194.0/255.0, blue: 202.0/255.0, alpha: 1 )
        title.backgroundColor = UIColor.clearColor()
        title.text = "导读"
        self.addSubview(title)
        var titled:UILabel = UILabel()
        titled.frame = CGRect(x: 184.0/2.0, y: 188.0/2.0, width: frame.size.width, height: 52.0/2.0)
        titled.font = UIFont.systemFontOfSize(12)
        titled.textAlignment = .Left
        titled.textColor = UIColor(red: 188.0/255.0, green: 194.0/255.0, blue: 202.0/255.0, alpha: 1 )
        titled.backgroundColor = UIColor.clearColor()
        titled.text = "点击左图添加或修改封面"
        self.addSubview(titled)
        var titleBg:UIView = UIView(frame: CGRect(x: 184.0/2.0, y: 240.0/2.0, width: frame.size.width-184.0/2.0 - 36.0/2.0, height: 68.0/2.0))
        titleBg.backgroundColor = UIColor(red: 225.0/255.0, green: 246.0/255.0, blue: 254.0/255.0, alpha:0.5)
        self.addSubview(titleBg)
        
        var desBg:UIView = UIView(frame: CGRect(x: 36.0/2.0, y: 378.0/2.0, width: frame.size.width - 36.0, height: 174.0/2.0))
        desBg.backgroundColor = UIColor(red: 225.0/255.0, green: 246.0/255.0, blue: 254.0/255.0, alpha:0.5)
        self.addSubview(desBg)
        var ch:CGFloat = 46.0/2.0
        count.frame = CGRect(x: desBg.frame.size.width-ch, y: desBg.frame.size.height-ch, width: ch, height: ch)
        count.font = UIFont.systemFontOfSize(12)
        count.textAlignment = .Left
        count.textColor = UIColor(red: 188.0/255.0, green: 194.0/255.0, blue: 202.0/255.0, alpha: 1 )
        count.backgroundColor = UIColor.clearColor()
        count.text = "36"
        desBg.addSubview(count)
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

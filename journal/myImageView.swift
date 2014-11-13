//
//  myImageView.swift
//  journal
//
//  Created by wuyangbing on 14/11/10.
//  Copyright (c) 2014年 wuyangbing. All rights reserved.
//

import UIKit

class myImageView: UIImageView {
    override init(frame:CGRect){
        super.init(frame: frame)
    }
    init(frame: CGRect, name:String! ,scale:CGFloat!) {
        super.init(frame: frame)
        userInteractionEnabled = true
        var r = name.rangeOfString(".jpg")
        var type = "png"
        if((r) != nil){
            type = "jpg"
        }
        var fn = NSBundle.mainBundle().pathForResource(name, ofType: type)!
        var img:UIImage = UIImage(contentsOfFile: fn)!
        self.image = UIImage(CGImage: img.CGImage, scale: scale, orientation: UIImageOrientation.Up)
    }
    init(name:String! ,scale:CGFloat! ,frame: CGRect) {

        var r = name.rangeOfString(".jpg")
        var type = "png"
        if((r) != nil){
            type = "jpg"
        }
        var fn = NSBundle.mainBundle().pathForResource(name, ofType: type)!
        var img:UIImage = UIImage(contentsOfFile: fn)!
        var imgSize = img.size
        super.init(image: UIImage(CGImage: img.CGImage, scale: scale, orientation: UIImageOrientation.Up))
        userInteractionEnabled = true
        self.frame = CGRect(x: frame.origin.x + (frame.size.width - imgSize.width/scale)/2.0, y: frame.origin.y + (frame.size.height - imgSize.height/scale)/2.0, width: imgSize.width/scale, height: imgSize.height/scale)
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func changeImg(name:String!,scale:CGFloat!){
        var r = name.rangeOfString(".jpg")
        var type = "png"
        if((r) != nil){
            type = "jpg"
        }
        var fn = NSBundle.mainBundle().pathForResource(name, ofType: type)!
        var img:UIImage = UIImage(contentsOfFile: fn)!
        self.image = UIImage(CGImage: img.CGImage, scale: scale, orientation: UIImageOrientation.Up)
    }
}

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
    class func getShadowImage(frame: CGRect)->UIImage{
        
        
        UIGraphicsBeginImageContext(frame.size)
        var imgRef:CGImageRef?
        var context = UIGraphicsGetCurrentContext()
        
        var gradLocationsNum:size_t = 2;
        var gradLocations:[CGFloat] = [0.0, 0.5];
//        var gradColors:[CGFloat] = [0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0];
        var gradColors:[CGFloat] = [1.0,1.0,1.0,1.0,1.0,1.0,1.0,0.0];
        var colorSpace = CGColorSpaceCreateDeviceRGB();
        var gradient = CGGradientCreateWithColorComponents(colorSpace, gradColors, gradLocations, gradLocationsNum);
        
        //Gradient center
        var startCenter = CGPoint(x:frame.size.width/2.0, y:frame.size.height);
        var endCenter = CGPoint(x:frame.size.width/2.0, y:frame.size.height);
        //Gradient radius
        var gradRadius = frame.size.width > frame.size.height ? frame.size.width : frame.size.height
        //Gradient draw
        
        CGContextDrawRadialGradient (context, gradient, startCenter,
            0.0, endCenter, gradRadius,0);
        
        CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, frame.size.width, frame.size.height), imgRef);
        var imageCopy = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return imageCopy;
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
    func setBadgeValue(badge:Int!){
        var bview = self.viewWithTag(10001)
        if(bview == nil)
        {
            var w:CGFloat = 15.0
            var t:CGFloat = 5.0
            bview = UIView(frame: CGRect(x: self.frame.width-w-t, y: t, width: w, height: w))
            bview?.tag = 10001
            bview?.backgroundColor = UIColor(red: 254.0/255.0, green: 25.0/255.0, blue: 29.0/255.0, alpha: 1.0 )
            bview?.backgroundColor = UIColor(red: 54.0/255.0, green: 215.0/255.0, blue: 79.0/255.0, alpha: 1.0 )
            bview?.layer.cornerRadius = CGFloat(w/2.0)
            var titled:UILabel = UILabel()
            titled.frame = CGRect(x: 0, y: 0, width: w, height: w)
            titled.font = UIFont(name:"ArialRoundedMTBold", size: 11)//.systemFontOfSize(11)
//            titled.font =
            titled.textAlignment = .Center
            titled.textColor = UIColor.whiteColor()
            titled.backgroundColor = UIColor.clearColor()
            titled.text = "\(badge)"
            titled.tag = 10043
            bview?.addSubview(titled)
            self.addSubview(bview!)
        }
        if let titled = bview?.viewWithTag(10043){
            if badge > 0 {
                bview?.hidden = false
                (titled as UILabel).text = "\(badge)"
                doudou(bview!)
            }else{
                bview?.hidden = true
            }
        }
    }
    func doudou(view:UIView!){
        var t:CATransform3D = CATransform3DIdentity
        let moveAnim:CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "transform")
        moveAnim.values = [NSValue(CATransform3D: CATransform3DScale(t, 1.3, 1.3, 1)),NSValue(CATransform3D: CATransform3DScale(t, 0.8, 0.8, 1)),NSValue(CATransform3D: CATransform3DScale(t, 1.1, 1.1, 1)),NSValue(CATransform3D: t)];
        moveAnim.removedOnCompletion = true
        moveAnim.duration = 0.5
        moveAnim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        moveAnim.removedOnCompletion = true
        moveAnim.fillMode = kCAFillModeForwards
        view.layer.addAnimation(moveAnim, forKey: "s")
    }
    func clearBadge(){
        setBadgeValue(0)
    }
}
